Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129681AbRBHVYy>; Thu, 8 Feb 2001 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131241AbRBHVYr>; Thu, 8 Feb 2001 16:24:47 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:7952 "EHLO tepid.osl.fast.no")
	by vger.kernel.org with ESMTP id <S130162AbRBHVYd>;
	Thu, 8 Feb 2001 16:24:33 -0500
Date: Thu, 8 Feb 2001 21:40:54 GMT
Message-Id: <200102082140.VAA88955@tepid.osl.fast.no>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.uit.no
From: Dag Brattli <dagb@fast.no>
Reply-To: dagb@fast.no
Subject: [patch] patch-2.4.1-irda3 (qos)
X-Mailer: Pygmy (v0.4.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply this patch to your latest 2.4 code. It contains
cleanups to the irda QoS code by Jean Tourrilhes.

-- Dag

diff -u -p linux/include/net/irda/qos.d6.h linux/include/net/irda/qos.h
--- linux/include/net/irda/qos.d6.h	Thu Jan 11 14:28:26 2001
+++ linux/include/net/irda/qos.h	Thu Jan 11 14:29:15 2001
@@ -100,10 +100,19 @@ void irda_qos_compute_intersection(struc
 
 __u32 irlap_max_line_capacity(__u32 speed, __u32 max_turn_time);
 __u32 irlap_requested_line_capacity(struct qos_info *qos);
-__u32 irlap_min_turn_time_in_bytes(__u32 speed, __u32 min_turn_time);
 
 int msb_index(__u16 byte);
 void irda_qos_bits_to_value(struct qos_info *qos);
+
+/* So simple, how could we not inline those two ?
+ * Note : one byte is 10 bits if you include start and stop bits
+ * Jean II */
+#define irlap_min_turn_time_in_bytes(speed, min_turn_time) (	\
+	speed * min_turn_time / 10000000			\
+)
+#define irlap_xbofs_in_usec(speed, xbofs) (			\
+	xbofs * 10000000 / speed				\
+)
 
 #endif
 
diff -u -p linux/net/irda/qos.d6.c linux/net/irda/qos.c
--- linux/net/irda/qos.d6.c	Thu Jan 11 14:28:40 2001
+++ linux/net/irda/qos.c	Thu Jan 11 14:29:15 2001
@@ -70,10 +70,6 @@ static int irlap_param_additional_bofs(v
 				       int get);
 static int irlap_param_min_turn_time(void *instance, irda_param_t *param, 
 				     int get);
-static int value_index(__u32 value, __u32 *array, int size);
-static __u32 byte_value(__u8 byte, __u32 *array);
-static __u32 index_value(int index, __u32 *array);
-static int value_lower_bits(__u32 value, __u32 *array, int size, __u16 *field);
 
 __u32 min_turn_times[]  = { 10000, 5000, 1000, 500, 100, 50, 10, 0 }; /* us */
 __u32 baud_rates[]      = { 2400, 9600, 19200, 38400, 57600, 115200, 576000, 
@@ -130,6 +126,98 @@ static pi_major_info_t pi_major_call_tab
 
 static pi_param_info_t irlap_param_info = { pi_major_call_table, 2, 0x7f, 7 };
 
+/* ---------------------- LOCAL SUBROUTINES ---------------------- */
+/* Note : we start with a bunch of local subroutines.
+ * As the compiler is "one pass", this is the only way to get them to
+ * inline properly...
+ * Jean II
+ */
+/*
+ * Function value_index (value, array, size)
+ *
+ *    Returns the index to the value in the specified array
+ */
+static inline int value_index(__u32 value, __u32 *array, int size)
+{
+	int i;
+	
+	for (i=0; i < size; i++)
+		if (array[i] == value)
+			break;
+	return i;
+}
+
+/*
+ * Function index_value (index, array)
+ *
+ *    Returns value to index in array, easy!
+ *
+ */
+static inline __u32 index_value(int index, __u32 *array) 
+{
+	return array[index];
+}
+
+/*
+ * Function msb_index (word)
+ *
+ *    Returns index to most significant bit (MSB) in word
+ *
+ */
+int msb_index (__u16 word) 
+{
+	__u16 msb = 0x8000;
+	int index = 15;   /* Current MSB */
+	
+	while (msb) {
+		if (word & msb)
+			break;   /* Found it! */
+		msb >>=1;
+		index--;
+	}
+	return index;
+}
+
+static inline __u32 byte_value(__u8 byte, __u32 *array) 
+{
+	int index;
+
+	ASSERT(array != NULL, return -1;);
+
+	index = msb_index(byte);
+
+	return index_value(index, array);
+}
+
+/*
+ * Function value_lower_bits (value, array)
+ *
+ *    Returns a bit field marking all possibility lower than value.
+ *    We may need a "value_higher_bits" in the future...
+ */
+static inline int value_lower_bits(__u32 value, __u32 *array, int size, __u16 *field)
+{
+	int	i;
+	__u16	mask = 0x1;
+	__u16	result = 0x0;
+
+	for (i=0; i < size; i++) {
+		/* Add the current value to the bit field, shift mask */
+		result |= mask;
+		mask <<= 1;
+		/* Finished ? */
+		if (array[i] >= value)
+			break;
+	}
+	/* Send back a valid index */
+	if(i >= size)
+	  i = size - 1;	/* Last item */
+	*field = result;
+	return i;
+}
+
+/* -------------------------- MAIN CALLS -------------------------- */
+
 /*
  * Function irda_qos_compute_intersection (qos, new)
  *
@@ -594,99 +682,6 @@ __u32 irlap_requested_line_capacity(stru
 		   line_capacity);
 	
 	return line_capacity;			       		  
-}
-
-__u32 irlap_min_turn_time_in_bytes(__u32 speed, __u32 min_turn_time)
-{
-	__u32 bytes;
-	
-	bytes = speed * min_turn_time / 10000000;
-	
-	return bytes;
-}
-
-static __u32 byte_value(__u8 byte, __u32 *array) 
-{
-	int index;
-
-	ASSERT(array != NULL, return -1;);
-
-	index = msb_index(byte);
-
-	return index_value(index, array);
-}
-
-/*
- * Function msb_index (word)
- *
- *    Returns index to most significant bit (MSB) in word
- *
- */
-int msb_index (__u16 word) 
-{
-	__u16 msb = 0x8000;
-	int index = 15;   /* Current MSB */
-	
-	while (msb) {
-		if (word & msb)
-			break;   /* Found it! */
-		msb >>=1;
-		index--;
-	}
-	return index;
-}
-
-/*
- * Function value_index (value, array, size)
- *
- *    Returns the index to the value in the specified array
- */
-static int value_index(__u32 value, __u32 *array, int size)
-{
-	int i;
-	
-	for (i=0; i < size; i++)
-		if (array[i] == value)
-			break;
-	return i;
-}
-
-/*
- * Function index_value (index, array)
- *
- *    Returns value to index in array, easy!
- *
- */
-static __u32 index_value(int index, __u32 *array) 
-{
-	return array[index];
-}
-
-/*
- * Function value_lower_bits (value, array)
- *
- *    Returns a bit field marking all possibility lower than value.
- *    We may need a "value_higher_bits" in the future...
- */
-static int value_lower_bits(__u32 value, __u32 *array, int size, __u16 *field)
-{
-	int	i;
-	__u16	mask = 0x1;
-	__u16	result = 0x0;
-
-	for (i=0; i < size; i++) {
-		/* Add the current value to the bit field, shift mask */
-		result |= mask;
-		mask <<= 1;
-		/* Finished ? */
-		if (array[i] >= value)
-			break;
-	}
-	/* Send back a valid index */
-	if(i >= size)
-	  i = size - 1;	/* Last item */
-	*field = result;
-	return i;
 }
 
 void irda_qos_bits_to_value(struct qos_info *qos)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
