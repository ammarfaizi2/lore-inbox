Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288990AbSAIUDe>; Wed, 9 Jan 2002 15:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288992AbSAIUDV>; Wed, 9 Jan 2002 15:03:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:21491 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288985AbSAIUC6>;
	Wed, 9 Jan 2002 15:02:58 -0500
Date: Wed, 9 Jan 2002 12:02:53 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir247_lpt_fix.diff
Message-ID: <20020109120253.C12039@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir247_lpt_fix.diff :
------------------
	o [CRITICA] Provide a valid skb when calling irlmp_connect_response()
	o [FEATURE] Display something meaningfull in /proc/net/irda/ircomm

diff -u -p -r linux/net/irda/ircomm-d8/ircomm_core.c linux/net/irda/ircomm/ircomm_core.c
--- linux/net/irda/ircomm-d8/ircomm_core.c	Sun Sep 30 12:26:09 2001
+++ linux/net/irda/ircomm/ircomm_core.c	Tue Jan  8 14:00:55 2002
@@ -490,18 +490,34 @@ int ircomm_proc_read(char *buf, char **s
 { 	
 	struct ircomm_cb *self;
 	unsigned long flags;
-	int i=0;
 	
 	save_flags(flags);
 	cli();
 
 	len = 0;
 
-	len += sprintf(buf+len, "Instance %d:\n", i++);
-
 	self = (struct ircomm_cb *) hashbin_get_first(ircomm);
 	while (self != NULL) {
 		ASSERT(self->magic == IRCOMM_MAGIC, return len;);
+
+		if(self->line < 0x10)
+			len += sprintf(buf+len, "ircomm%d", self->line);
+		else
+			len += sprintf(buf+len, "irlpt%d", self->line - 0x10);
+		len += sprintf(buf+len, " state: %s, ",
+			       ircomm_state[ self->state]);
+		len += sprintf(buf+len, 
+			       "slsap_sel: %#02x, dlsap_sel: %#02x, mode:",
+			       self->slsap_sel, self->dlsap_sel); 
+		if(self->service_type & IRCOMM_3_WIRE_RAW)
+			len += sprintf(buf+len, " 3-wire-raw");
+		if(self->service_type & IRCOMM_3_WIRE)
+			len += sprintf(buf+len, " 3-wire");
+		if(self->service_type & IRCOMM_9_WIRE)
+			len += sprintf(buf+len, " 9-wire");
+		if(self->service_type & IRCOMM_CENTRONICS)
+			len += sprintf(buf+len, " Centronics");
+		len += sprintf(buf+len, "\n");
 
 		self = (struct ircomm_cb *) hashbin_get_next(ircomm);
  	} 
diff -u -p -r linux/net/irda/ircomm-d8/ircomm_lmp.c linux/net/irda/ircomm/ircomm_lmp.c
--- linux/net/irda/ircomm-d8/ircomm_lmp.c	Fri Mar  2 11:12:12 2001
+++ linux/net/irda/ircomm/ircomm_lmp.c	Tue Jan  8 14:10:27 2002
@@ -103,12 +103,30 @@ int ircomm_lmp_connect_request(struct ir
  *    
  *
  */
-int ircomm_lmp_connect_response(struct ircomm_cb *self, struct sk_buff *skb)
+int ircomm_lmp_connect_response(struct ircomm_cb *self, struct sk_buff *userdata)
 {
+	struct sk_buff *skb;
 	int ret;
 
 	IRDA_DEBUG(0, __FUNCTION__"()\n");
 	
+	/* Any userdata supplied? */
+	if (userdata == NULL) {
+		skb = dev_alloc_skb(64);
+		if (!skb)
+			return -ENOMEM;
+
+		/* Reserve space for MUX and LAP header */
+		skb_reserve(skb, LMP_MAX_HEADER);
+	} else {
+		skb = userdata;
+		/*  
+		 *  Check that the client has reserved enough space for 
+		 *  headers
+		 */
+		ASSERT(skb_headroom(skb) >= LMP_MAX_HEADER, return -1;);
+	}
+
 	ret = irlmp_connect_response(self->lsap, skb);
 
 	return 0;
