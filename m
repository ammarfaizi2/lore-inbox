Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281697AbRKUKk7>; Wed, 21 Nov 2001 05:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281563AbRKUKku>; Wed, 21 Nov 2001 05:40:50 -0500
Received: from [195.66.192.167] ([195.66.192.167]:49938 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281697AbRKUKkg>; Wed, 21 Nov 2001 05:40:36 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Bad #define, nonportable C, missing {}
Date: Wed, 21 Nov 2001 12:40:17 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01112112401703.01961@nemo>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Upon random browsing in the kernel tree I noticed in accel.c:
    *a++ = byte_rev[*a]
which isn't 100% correct C AFAIK. At least Stroustrup in his C++ book
warns that this kind of code has to be avoided.
Wrote a script to catch similar things all over the tree (attached).
Found some buglets. Here they are:

drivers/message/i2o/i2o_config.c:#define MODINC(x,y) (x = x++ % y)
---------------------------------------------------
Bad code style. Bad name (sounds like 'module inc').
I can't even tell from this define what the hell it is trying to do:
x++ will return unchanged x, then we obtain (x mod y),
then we store it into x... and why x++ then??!
Alan, seems like you can help here...


drivers/isdn/isdn_audio.c:     *buff++ = table[*(unsigned char *)buff];
drivers/video/riva/accel.c:     *a++ = byte_rev[*a];
drivers/video/riva/accel.c:/*   *a++ = byte_rev[*a];
drivers/video/riva/accel.c:     *a++ = byte_rev[*a];*/
drivers/usb/se401.c:            
*frame++=(((*frame^255)*(*frame^255))/255)^255;
arch/mips/lib/tinycon.c:    *(caddr++) = *(caddr + size_x);
arch/mips/lib/tinycon.c:    *(caddr++) = (*caddr & 0xff00) | (unsigned short) 
' ';
    (btw, tinycon.c seriously needs Lindenting)
------------------------------------------------------------------
Undefined behavior by C std: inc/dec may happen before dereference.
Probably GCC is doing inc after right side eval, but standards say nothing
about it AFAIK. Move ++ out of the statement to be safe:
    *a++ = byte_rev[*a]; => *a = byte_rev[*a]; a++;
Patch is attached.


drivers/block/paride/pf.c:      if (l==0x20) j--; targ[j]=0;
drivers/block/paride/pg.c:      if (l==0x20) j--; targ[j]=0;
drivers/block/paride/pt.c:      if (l==0x20) j--; targ[j]=0;
    (these files need Lindenting too)
----------
Missing {}
Either a bug or a very bad style (so bad that I can even imagine
that it is NOT a bug). Please double check before applying the patch!
--
vda

======= bad_c.diff =======
diff -u --recursive linux-2.4.13-old/arch/mips/lib/tinycon.c 
linux-2.4.13-new/arch/mips/lib/tinycon.c
--- linux-2.4.13-old/arch/mips/lib/tinycon.c	Thu Jun 26 17:33:37 1997
+++ linux-2.4.13-new/arch/mips/lib/tinycon.c	Wed Nov 21 00:54:05 2001
@@ -83,14 +83,18 @@
   register int i;
 
   caddr = vram_addr;
-  for(i=0; i<size_x * (size_y-1); i++)
-    *(caddr++) = *(caddr + size_x);
+  for(i=0; i<size_x * (size_y-1); i++) {
+    *caddr = *(caddr + size_x);
+    caddr++;
+  }
 
   /* blank last line */
   
   caddr = vram_addr + (size_x * (size_y-1));
-  for(i=0; i<size_x; i++)
-    *(caddr++) = (*caddr & 0xff00) | (unsigned short) ' ';
+  for(i=0; i<size_x; i++) {
+    *caddr = (*caddr & 0xff00) | (unsigned short) ' ';
+    caddr++;
+  }
 }
 
 void print_string(const unsigned char *str)
diff -u --recursive linux-2.4.13-old/drivers/isdn/isdn_audio.c 
linux-2.4.13-new/drivers/isdn/isdn_audio.c
--- linux-2.4.13-old/drivers/isdn/isdn_audio.c	Sun Sep 30 17:26:06 2001
+++ linux-2.4.13-new/drivers/isdn/isdn_audio.c	Wed Nov 21 00:49:54 2001
@@ -227,8 +227,10 @@
 	:	"0"((long) table), "1"(n), "2"((long) buff), "3"((long) buff)
 	:	"memory", "ax");
 #else
-	while (n--)
-		*buff++ = table[*(unsigned char *)buff];
+	while (n--) {
+		*buff = table[*(unsigned char *)buff];
+		buff++;
+	}
 #endif
 }
 
diff -u --recursive linux-2.4.13-old/drivers/usb/se401.c 
linux-2.4.13-new/drivers/usb/se401.c
--- linux-2.4.13-old/drivers/usb/se401.c	Fri Sep 14 19:27:10 2001
+++ linux-2.4.13-new/drivers/usb/se401.c	Wed Nov 21 00:52:46 2001
@@ -738,7 +738,8 @@
 static inline void enhance_picture(unsigned char *frame, int len)
 {
 	while (len--) {
-		*frame++=(((*frame^255)*(*frame^255))/255)^255;
+		*frame = (((*frame^255)*(*frame^255))/255) ^ 255;
+		frame++;
 	}
 }
 
diff -u --recursive linux-2.4.13-old/drivers/video/riva/accel.c 
linux-2.4.13-new/drivers/video/riva/accel.c
--- linux-2.4.13-old/drivers/video/riva/accel.c	Mon Oct 15 18:47:13 2001
+++ linux-2.4.13-new/drivers/video/riva/accel.c	Wed Nov 21 00:50:32 2001
@@ -108,9 +108,9 @@
 static inline void fbcon_reverse_order(u32 *l)
 {
 	u8 *a = (u8 *)l;
-	*a++ = byte_rev[*a];
-/*	*a++ = byte_rev[*a];
-	*a++ = byte_rev[*a];*/
+	*a = byte_rev[*a]; a++;
+/*	*a = byte_rev[*a]; a++;
+	*a = byte_rev[*a]; a++; */
 	*a = byte_rev[*a];
 }
 
======= paride.diff =======
diff -u --recursive linux-2.4.13-old/drivers/block/paride/pf.c 
linux-2.4.13-new/drivers/block/paride/pf.c
--- linux-2.4.13-old/drivers/block/paride/pf.c	Thu Nov  8 23:42:11 2001
+++ linux-2.4.13-new/drivers/block/paride/pf.c	Wed Nov 21 01:00:16 2001
@@ -737,10 +737,13 @@
 {	int	j,k,l;
 
 	j=0; l=0;
-	for (k=0;k<len;k++) 
-	   if((buf[k+offs]!=0x20)||(buf[k+offs]!=l))
-		l=targ[j++]=buf[k+offs];
-	if (l==0x20) j--; targ[j]=0;
+	for(k=0;k<len;k++) 
+		if((buf[k+offs]!=0x20) || (buf[k+offs]!=l))
+			l = targ[j++] = buf[k+offs];
+	if(l==0x20) { 
+		j--;
+		targ[j]=0; 
+	}
 }
 
 static int xl( char *buf, int offs )
diff -u --recursive linux-2.4.13-old/drivers/block/paride/pg.c 
linux-2.4.13-new/drivers/block/paride/pg.c
--- linux-2.4.13-old/drivers/block/paride/pg.c	Thu Nov  8 23:42:11 2001
+++ linux-2.4.13-new/drivers/block/paride/pg.c	Wed Nov 21 01:00:25 2001
@@ -488,10 +488,13 @@
 {	int	j,k,l;
 
 	j=0; l=0;
-	for (k=0;k<len;k++) 
-	   if((buf[k+offs]!=0x20)||(buf[k+offs]!=l))
-		l=targ[j++]=buf[k+offs];
-	if (l==0x20) j--; targ[j]=0;
+	for(k=0;k<len;k++) 
+		if((buf[k+offs]!=0x20) || (buf[k+offs]!=l))
+			l = targ[j++] = buf[k+offs];
+	if(l==0x20) { 
+		j--;
+		targ[j]=0; 
+	}
 }
 
 static int pg_identify( int unit, int log )
diff -u --recursive linux-2.4.13-old/drivers/block/paride/pt.c 
linux-2.4.13-new/drivers/block/paride/pt.c
--- linux-2.4.13-old/drivers/block/paride/pt.c	Thu Nov  8 23:42:11 2001
+++ linux-2.4.13-new/drivers/block/paride/pt.c	Wed Nov 21 00:59:44 2001
@@ -574,10 +574,13 @@
 {	int	j,k,l;
 
 	j=0; l=0;
-	for (k=0;k<len;k++) 
-	   if((buf[k+offs]!=0x20)||(buf[k+offs]!=l))
-		l=targ[j++]=buf[k+offs];
-	if (l==0x20) j--; targ[j]=0;
+	for(k=0;k<len;k++)
+		if((buf[k+offs]!=0x20) || (buf[k+offs]!=l))
+			l = targ[j++] = buf[k+offs];
+	if(l==0x20) {
+		j--;
+		targ[j]=0;
+	}
 }
 
 static int xn( char *buf, int offs, int size )
 
======= bughunter.sh with some lines wrapped by kmail :-( =======
#!/bin/sh
function do_grep() {
    pattern="$1"
    shift
    for i in $@; do
        if test -d "$i"; then
	    do_grep $pattern $i/*
        else
	    #echo "$i"
	    #echo grep -E $pattern "$i" /dev/null
	    grep -E $pattern "$i" /dev/null
        fi
    done
}

# skip lines from doc dir and with for loops (way too many false alarms)

# *var++ ... *var
do_grep 
'[^0-9A-Za-z_]([A-Za-z_][0-9A-Za-z_]*)\+\+.*[^0-9A-Za-z_]\1[^0-9A-Za-z_]' * 
2>/dev/null \
| grep -E '(for)|(Documentation)' -v >!vpp_v 2>&1 &

# *var-- ... *var
do_grep 
'[^0-9A-Za-z_]([A-Za-z_][0-9A-Za-z_]*)--.*[^0-9A-Za-z_]\1[^0-9A-Za-z_]'   * 
2>/dev/null  \
| grep -E '(for)|(Documentation)' -v >!vmm_v 2>&1 &

# *var ... *var++
do_grep 
'[^0-9A-Za-z_]([A-Za-z_][0-9A-Za-z_]*)[^0-9A-Za-z_].*[^0-9A-Za-z_]\1\+\+' * 
2>/dev/null  \
| grep -E '(for)|(Documentation)' -v >!v_vpp 2>&1 &

# *var ... *var--
do_grep 
'[^0-9A-Za-z_]([A-Za-z_][0-9A-Za-z_]*)[^0-9A-Za-z_].*[^0-9A-Za-z_]\1--'   * 
2>/dev/null  \
| grep -E '(for)|(Documentation)' -v >!v_vmm 2>&1 &
