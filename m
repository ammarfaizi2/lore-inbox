Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268694AbRGZVUB>; Thu, 26 Jul 2001 17:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268695AbRGZVTw>; Thu, 26 Jul 2001 17:19:52 -0400
Received: from lila.inti.gov.ar ([200.10.161.32]:16012 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S268694AbRGZVTa>;
	Thu, 26 Jul 2001 17:19:30 -0400
Message-ID: <3B60898A.1C118D65@inti.gov.ar>
Date: Thu, 26 Jul 2001 18:20:10 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC/A] Small addition to console driver
Content-Type: multipart/mixed;
 boundary="------------4C063559456BEB2569C1F10C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------4C063559456BEB2569C1F10C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all:

Disclaimer:
  I'm new here, sorry if I doing something wrong.

What I'm looking for:
  I'm looking for comments and approval for a small addition to the console
driver (drivers/char/console.c).

Small description:
  The attached patches adds a couple of new services to the TIOCLINUX ioctl
call, they are:

13 (get selection into a buffer): It copies the contents of the selection
buffer (maintained in kernel space) into a user space provided buffer. Is
something like "paste to a buffer"  instead of just paste to the current
console.

14 (get selection length): Returns the length of the selection buffer (0 if
none selected).
-----------

The attached file (patch.diff) contains diffs that apply without offsets
into 2.4.7 kernel, they are valid for 2.2.18 too (with offset).
I also attached a simple test. It is in spanish but the code is quite
obvious.

Additional question: Why the switch uses numbers? Shouldn't these values be
defined as something like TIOCLINUX_GET_SELECTION in a header?

What's the purpose? Just allow pasting in text editors using menues or
without the mouse middle button.

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set-soft@bigfoot.com set@computer.org
                    set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



--------------4C063559456BEB2569C1F10C
Content-Type: text/plain; charset=us-ascii;
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.diff"

--- drivers/char/console.c.ori	Tue Jun 12 15:17:17 2001
+++ drivers/char/console.c	Thu Jul 26 17:33:46 2001
@@ -14,6 +14,8 @@
  *
  * Copy and paste function by Andrew Haylett,
  *   some enhancements by Alessandro Rubini.
+ *   get selection into a buffer and length by
+ *       Salvador E. Tropea <salvador@inti.gov.ar>
  *
  * Code to check for different video-cards mostly by Galen Hunt,
  * <g-hunt@ee.utah.edu>
@@ -2204,6 +2206,10 @@
 			return 0;
 		case 12:	/* get fg_console */
 			return fg_console;
+		case 13:	/* get selection into a buffer */
+			return get_selection_buffer(arg);
+		case 14:	/* get selection length */
+			return put_user(get_selection_length(), (unsigned int *)((char *)arg + 1));
 	}
 	return -EINVAL;
 }
--- drivers/char/selection.c.ori	Fri Feb  9 16:30:22 2001
+++ drivers/char/selection.c	Thu Jul 26 17:53:46 2001
@@ -288,6 +288,41 @@
 	return 0;
 }
 
+/* Copy the contents of the selection buffer into a
+ * user space buffer.
+ * Invoked by ioctl().
+ */
+int get_selection_buffer(const unsigned long arg)
+{
+	char *dest;
+	unsigned int length;
+	 
+	if (get_user(length, (unsigned int *)(arg + sizeof(char))))
+		return -EFAULT;
+	   
+	dest = (char *)(arg + sizeof(char) + sizeof(unsigned int));
+	
+	if (length > sel_buffer_lth)
+		length = sel_buffer_lth;
+	
+	if (sel_buffer) {
+		if (copy_to_user(dest, sel_buffer, length))
+			return -EFAULT;
+	} else {
+		length = 0;
+	}
+	__put_user(length, (unsigned long *)(arg + sizeof(char)));
+	return 0;
+}
+
+/* Get the selection buffer length.
+ * Invoked by ioctl().
+ */
+unsigned int get_selection_length(void)
+{
+	return sel_buffer ? sel_buffer_lth : 0;
+}
+
 /* Insert the contents of the selection buffer into the
  * queue of the tty associated with the current console.
  * Invoked by ioctl().
--- include/linux/selection.h.ori	Fri Jul 20 16:53:56 2001
+++ include/linux/selection.h	Thu Jul 26 17:40:07 2001
@@ -17,6 +17,8 @@
 extern int sel_loadlut(const unsigned long arg);
 extern int mouse_reporting(void);
 extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
+extern int get_selection_buffer(const unsigned long arg);
+extern unsigned int get_selection_length(void);
 
 #define video_num_columns	(vc_cons[currcons].d->vc_cols)
 #define video_num_lines		(vc_cons[currcons].d->vc_rows)

--------------4C063559456BEB2569C1F10C
Content-Type: text/plain; charset=us-ascii;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

#include <stdio.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
 int i,res,fd,largo;
 char buffer[sizeof(unsigned int)+2],*s;
 unsigned int *lg=(unsigned int *)(buffer+1);

 fd=open("/dev/tty1",O_RDWR);

 printf("Averiguando el largo de la seleccion:\n");
 buffer[0]=14;
 res=ioctl(fd,TIOCLINUX,&buffer);
 printf("La iotcl devuelve %d\n",res);
 printf("Largo: %u\n",*lg);
 largo=*lg;
 if (*lg==0) return 0;

 printf("Pidiendo la seleccion:\n");
 s=(char *)malloc(largo+sizeof(unsigned int)+2);
 s[0]=13;
 lg=(unsigned int *)(s+1);
 *lg=largo;
 res=ioctl(fd,TIOCLINUX,s);
 printf("La iotcl devuelve %d\n",res);
 largo=*lg;
 printf("Largo devuelto: %d\n",largo);
 s+=1+sizeof(unsigned int);
 s[largo]=0;

 for (i=0; s[i]; i++)
     if (s[i]==13) s[i]=10;
 printf("Dice esto: '%s' (%d)\n",s,s[0]);
 return 0;
}

--------------4C063559456BEB2569C1F10C--

