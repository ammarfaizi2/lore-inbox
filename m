Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbSK2Q1b>; Fri, 29 Nov 2002 11:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267105AbSK2Q1a>; Fri, 29 Nov 2002 11:27:30 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:33227 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S267104AbSK2Q13>;
	Fri, 29 Nov 2002 11:27:29 -0500
Date: Fri, 29 Nov 2002 18:48:51 -0500
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@conectiva.com.br
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] faster swab64 on x86
Message-ID: <20021129184851.A13007@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, marcelo@conectiva.com.br,
	ak@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch from Andi Kleen speeds up swab64 on x86 cpus that
implement the bswapl significatnly.  It has been in the XFS tree
for a while and shows nice improvements when't it's heavily used.


--- linux/include/asm-i386/byteorder.h	Fri Jun 25 19:32:48 1999
+++ linux/include/asm-i386/byteorder.h	Mon Oct 14 20:52:05 2002
@@ -24,21 +24,41 @@
 	return x;
 }
 
+/* gcc should generate this for open coded C now too. May be worth switching to 
+   it because inline assembly cannot be scheduled. -AK */
 static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
 {
-	__asm__("xchgb %b0,%h0"		/* swap bytes		*/ \
-		: "=q" (x) \
-		:  "0" (x)); \
+	__asm__("xchgb %b0,%h0"		/* swap bytes		*/
+		: "=q" (x)
+		:  "0" (x));
 		return x;
 }
 
+
+static inline __u64 ___arch__swab64(__u64 val) 
+{ 
+	union { 
+		struct { __u32 a,b; } s;
+		__u64 u;
+	} v;
+	v.u = val;
+#ifdef CONFIG_X86_BSWAP
+	asm("bswapl %0 ; bswapl %1 ; xchgl %0,%1" 
+	    : "=r" (v.s.a), "=r" (v.s.b) 
+	    : "0" (v.s.a), "1" (v.s.b)); 
+#else
+   v.s.a = ___arch__swab32(v.s.a); 
+	v.s.b = ___arch__swab32(v.s.b); 
+	asm("xchgl %0,%1" : "=r" (v.s.a), "=r" (v.s.b) : "0" (v.s.a), "1" (v.s.b));
+#endif
+	return v.u;	
+} 
+
+#define __arch__swab64(x) ___arch__swab64(x)
 #define __arch__swab32(x) ___arch__swab32(x)
 #define __arch__swab16(x) ___arch__swab16(x)
 
-#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
-#  define __BYTEORDER_HAS_U64__
-#  define __SWAB_64_THRU_32__
-#endif
+#define __BYTEORDER_HAS_U64__
 
 #endif /* __GNUC__ */
 
