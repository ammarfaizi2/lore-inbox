Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSDCNnL>; Wed, 3 Apr 2002 08:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311670AbSDCNnC>; Wed, 3 Apr 2002 08:43:02 -0500
Received: from gold.muskoka.com ([216.123.107.5]:18437 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S311320AbSDCNmo>;
	Wed, 3 Apr 2002 08:42:44 -0500
Message-ID: <3CAB032D.1E648BA0@yahoo.com>
Date: Wed, 03 Apr 2002 08:27:09 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.18 i586)
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omission in video driver
In-Reply-To: <UTC200204011841.SAA486178.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> Documenting the video ioctls, I noticed to my dismay
> that the ioctl to set the border color of the console
> screen is lacking.
> 
> Here part of the fix for 2.4.19:
... 
> [this is the nontrivial part; the rest is left as an exercise]

Heh, you mean "here is the hardware information, please make a patch".
But your choice of red makes it truly a "bleeding edge" kernel  :)

The fact that we have been using linux for ~ 10 yrs and nobody has
complained about the lack of this function yet says something...

Anyway, have a look at this and see if it is what you had in mind.
I figured it would be sensible to have a per VC colour, which is the 
way I've done it. At end of 2.4.19pre5 patch is a $0.02 test program.

Paul.

diff -ur ../linux/include/linux/console.h include/linux/console.h
--- ../linux/include/linux/console.h	Thu Nov 22 11:46:19 2001
+++ include/linux/console.h	Wed Apr  3 07:18:43 2002
@@ -41,6 +41,7 @@
 	int	(*con_blank)(struct vc_data *, int);
 	int	(*con_font_op)(struct vc_data *, struct console_font_op *);
 	int	(*con_set_palette)(struct vc_data *, unsigned char *);
+	void	(*con_border)(struct vc_data *);
 	int	(*con_scrolldelta)(struct vc_data *, int);
 	int	(*con_set_origin)(struct vc_data *);
 	void	(*con_save_screen)(struct vc_data *);
diff -ur ../linux/include/linux/console_struct.h include/linux/console_struct.h
--- ../linux/include/linux/console_struct.h	Thu Oct 11 11:17:22 2001
+++ include/linux/console_struct.h	Wed Apr  3 07:18:43 2002
@@ -23,6 +23,7 @@
 	unsigned char	vc_def_color;		/* Default colors */
 	unsigned char	vc_color;		/* Foreground & background */
 	unsigned char	vc_s_color;		/* Saved foreground & background */
+	unsigned char	vc_border;		/* Border color */
 	unsigned char	vc_ulcolor;		/* Color for underline mode */
 	unsigned char	vc_halfcolor;		/* Color for half intensity mode */
 	unsigned short	vc_complement_mask;	/* [#] Xor mask for mouse pointer */
diff -ur ../linux/include/linux/kd.h include/linux/kd.h
--- ../linux/include/linux/kd.h	Tue Aug  4 10:52:57 1998
+++ include/linux/kd.h	Wed Apr  3 07:18:43 2002
@@ -155,6 +155,9 @@
 
 #define KDFONTOP	0x4B72	/* font operations */
 
+#define PIO_BORDER	0x4B73	/* Border color */
+#define GIO_BORDER	0x4B74
+
 struct console_font_op {
 	unsigned int op;	/* operation code KD_FONT_OP_* */
 	unsigned int flags;	/* KD_FONT_FLAG_* */
@@ -175,6 +178,6 @@
 
 /* note: 0x4B00-0x4B4E all have had a value at some time;
    don't reuse for the time being */
-/* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */
+/* note: 0x4B60-0x4B6D, 0x4B70-0x4B74 used above */
 
 #endif /* _LINUX_KD_H */
diff -ur ../linux/include/linux/vt_kern.h include/linux/vt_kern.h
--- ../linux/include/linux/vt_kern.h	Sun Sep 23 10:31:02 2001
+++ include/linux/vt_kern.h	Wed Apr  3 07:18:43 2002
@@ -47,12 +47,15 @@
 void vc_disallocate(unsigned int console);
 void reset_palette(int currcons);
 void set_palette(int currcons);
+void set_border(int currcons);
 void do_blank_screen(int gfx_mode);
 void unblank_screen(void);
 void poke_blanked_console(void);
 int con_font_op(int currcons, struct console_font_op *op);
 int con_set_cmap(unsigned char *cmap);
 int con_get_cmap(unsigned char *cmap);
+int con_set_border(int currcons, unsigned char *arg);
+int con_get_border(int currcons, unsigned char *arg);
 void scrollback(int);
 void scrollfront(int);
 void update_region(int currcons, unsigned long start, int count);
--- ../linux/drivers/char/console.c	Fri Dec 21 16:40:32 2001
+++ drivers/char/console.c	Wed Apr  3 07:18:43 2002
@@ -608,6 +608,7 @@
 		set_origin(currcons);
 		update = sw->con_switch(vc_cons[currcons].d);
 		set_palette(currcons);
+		set_border(currcons);
 		if (update && vcmode != KD_GRAPHICS)
 			do_update_region(currcons, origin, screenbuf_size/2);
 	}
@@ -2425,6 +2426,7 @@
 	def_color       = 0x07;   /* white */
 	ulcolor		= 0x0f;   /* bold white */
 	halfcolor       = 0x08;   /* grey */
+	border		= 0x00;	  /* black */
 	init_waitqueue_head(&vt_cons[currcons]->paste_wait);
 	reset_terminal(currcons, do_clear);
 }
@@ -2749,6 +2751,7 @@
 	if (console_blank_hook)
 		console_blank_hook(0);
 	set_palette(currcons);
+	set_border(currcons);
 	if (sw->con_blank(vc_cons[currcons].d, 0))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(fg_console);
@@ -2838,6 +2841,31 @@
 		palette[k++] = default_blu[j];
 	}
 	set_palette(currcons);
+}
+
+/*
+ *	Borders
+ */
+
+int con_set_border(int currcons, unsigned char *arg)
+{
+	if (get_user(border, arg))
+		return -EFAULT;
+	set_border(currcons);
+	return 0;
+}
+
+int con_get_border(int currcons, unsigned char *arg)
+{
+	if (put_user(border, arg))
+		return -EFAULT;
+	return 0;
+}
+
+void set_border(int currcons)
+{
+	if (vcmode != KD_GRAPHICS && sw->con_border != NULL)
+		sw->con_border(vc_cons[currcons].d);
 }
 
 /*
--- ../linux/drivers/char/vt.c	Fri Nov 16 10:08:28 2001
+++ drivers/char/vt.c	Wed Apr  3 08:16:23 2002
@@ -8,6 +8,7 @@
  *  Restrict VT switching via ioctl() - grif@cs.ucr.edu - Dec 1995
  *  Some code moved for less code duplication - Andi Kleen - Mar 1997
  *  Check put/get_user, cleanups - acme@conectiva.com.br - Jun 2001
+ *  Get/set VT border color - Paul Gortmaker/aeb - Apr 2002
  */
 
 #include <linux/config.h>
@@ -967,6 +968,14 @@
 
 	case GIO_CMAP:
                 return con_get_cmap((char *)arg);
+
+	case PIO_BORDER:
+                if (!perm)
+			return -EPERM;
+                return con_set_border(fg_console, (unsigned char *)arg);
+
+	case GIO_BORDER:
+                return con_get_border(fg_console, (unsigned char *)arg);
 
 	case PIO_FONTX:
 	case GIO_FONTX:
--- ../linux/drivers/video/vgacon.c	Thu Feb 28 13:57:29 2002
+++ drivers/video/vgacon.c	Wed Apr  3 08:13:44 2002
@@ -86,6 +86,7 @@
 static void vgacon_deinit(struct vc_data *c);
 static void vgacon_cursor(struct vc_data *c, int mode);
 static int vgacon_switch(struct vc_data *c);
+static void vgacon_border(struct vc_data *c);
 static int vgacon_blank(struct vc_data *c, int blank);
 static int vgacon_font_op(struct vc_data *c, struct console_font_op *op);
 static int vgacon_set_palette(struct vc_data *c, unsigned char *table);
@@ -470,6 +471,22 @@
     }
 }
 
+static void vgacon_border(struct vc_data *c)
+{
+	unsigned long flags;
+	unsigned char color = c->vc_border & 0x0f;
+
+	if (c->vc_can_do_color == 0)
+		return;
+
+	spin_lock_irqsave(&vga_lock, flags);
+	inb_p(0x3da);		/* clear flipflop */
+	outb_p(0x11, 0x3c0);	/* index overscan color reg */
+	outb_p(color, 0x3c0);	/* load color value */ 
+	outb_p(0x20, 0x3c0);	/* allow display memory */
+	spin_unlock_irqrestore(&vga_lock, flags);
+}
+
 static int vgacon_switch(struct vc_data *c)
 {
 	/*
@@ -1042,6 +1059,7 @@
 	con_scroll:		vgacon_scroll,
 	con_bmove:		DUMMY,
 	con_switch:		vgacon_switch,
+	con_border:		vgacon_border,
 	con_blank:		vgacon_blank,
 	con_font_op:		vgacon_font_op,
 	con_set_palette:	vgacon_set_palette,
--- ../linux/drivers/char/console_macros.h	Thu Sep 17 09:35:03 1998
+++ drivers/char/console_macros.h	Wed Apr  3 07:18:43 2002
@@ -41,6 +41,7 @@
 #define color		(vc_cons[currcons].d->vc_color)
 #define s_color		(vc_cons[currcons].d->vc_s_color)
 #define def_color	(vc_cons[currcons].d->vc_def_color)
+#define border		(vc_cons[currcons].d->vc_border)
 #define foreground	(color & 0x0f)
 #define background	(color & 0xf0)
 #define charset		(vc_cons[currcons].d->vc_charset)

-----------------8<---------------8<-----------8<-------------------
/*
 * set VGA border colour.
 *
 * 0 -> 7 are blk, blu, grn, cyn, red, mag, yel, wht.
 * 8 -> 15 are brighter versions (bright version of blk = grey).
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <asm/io.h>

/* #include <linux/kd.h> */
#define PIO_BORDER     0x4B73
#define GIO_BORDER     0x4B74

int main(int argc, char** argv)
{
	unsigned char colour, oldcolour;
	int i;

	if (argc != 2) {
		fprintf(stderr,"Usage %s <colour_number>\n", argv[0]);
		exit(EINVAL);
	}

	colour = atoi(argv[1]) & 0xf;
	
	i = ioctl(0, GIO_BORDER, &oldcolour);
	if (i != 0) {
		perror("ioctl(GIO_BORDER)");
		exit(errno);
	}
	printf("Old colour was %d\n", oldcolour);

	i = ioctl(0, PIO_BORDER, &colour);
	if (i != 0) {
		perror("ioctl(PIO_BORDER)");
		exit(errno);
	}

	return 0;
}

