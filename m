Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129960AbQKTCos>; Sun, 19 Nov 2000 21:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130394AbQKTCoh>; Sun, 19 Nov 2000 21:44:37 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:63754 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129960AbQKTCoa>;
	Sun, 19 Nov 2000 21:44:30 -0500
Date: Mon, 20 Nov 2000 03:14:24 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bttv_card & bttv_radio (was Re: BTTV detection broken in 2.4.0-test11-pre5)
Message-ID: <20001120031424.A32756@almesberger.net>
In-Reply-To: <20001117013157.A21329@almesberger.net> <slrn91b42n.fs.kraxel@bogomips.masq.in-berlin.de> <20001118141426.B23033@almesberger.net> <slrn91f3hr.jt.kraxel@bogomips.masq.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn91f3hr.jt.kraxel@bogomips.masq.in-berlin.de>; from kraxel@bytesex.org on Sun, Nov 19, 2000 at 08:24:27AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> Why?  What is the point in compiling bttv statically into the kernel?

Well, I see the modules vs. static flame war is already in progress ;-)

My reason for wanting static kernels is that I usually build many, very
different versions of the same kernel, among which I frequently switch
back and forth, and which I copy to different machines. Modules just get
in the way here.

I'm not at all against modules in general, quite to the contrary, but
there are cases where a static kernel is preferrable, and since it's
easy to keep the driver usable also without modules, I think it's worth
the effort.

Since we don't have Keith Owens' wonderful extension yet, I've made a
patch for 2.4.0-test11-pre7 that adds the new option bttv_card, and
renames bt848_radio to bttv_radio, replacing my previous patch. It also
fixes a rather embarrassing mistake I made in the bt848_radio patch ...

- Werner

---------------------------------- cut here -----------------------------------

--- linux.orig/Documentation/kernel-parameters.txt	Tue Sep  5 22:51:14 2000
+++ linux/Documentation/kernel-parameters.txt	Mon Nov 20 02:15:59 2000
@@ -43,6 +43,7 @@
 	SERIAL	Serial support is enabled.
 	SMP 	The kernel is an SMP kernel.
 	SOUND	Appropriate sound system support is enabled.
+	V4L	Video For Linux support is enabled.
 	VGA 	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
 	XT	IBM PC/XT MFM hard disk support is enabled.
@@ -115,6 +116,20 @@
 			Duplex Mode.
 
 	bmouse=		[HW,MOUSE,PS2] Bus mouse.
+
+	bttv_card=	[HW,V4L] Specify the model of the BT848/878 card(s),
+			superseding any auto-detection. The values are
+			described in Documentation/video4linux/bttv/CARDLIST.
+			E.g. bttv_card=2 specifies "Hauppauge old" for the
+			first card, bttv_card=3,3 specifies "STB" for the
+			first two cards.
+
+	bttv_radio=	[HW,V4L] Enables the FM radio tuners of BT848/878
+			cards. This parameter corresponds to the radio= module
+			parameter if the driver is compiled as such, e.g.
+			bttv_radio=1 enables the radio of the first card,
+			bttv_radio=0,1 enables the radio of the second card,
+			etc.
 
 	BusLogic=	[HW,SCSI]
 
--- linux.orig/drivers/media/video/bttv-cards.c	Mon Nov 20 02:07:47 2000
+++ linux/drivers/media/video/bttv-cards.c	Mon Nov 20 03:07:22 2000
@@ -1319,6 +1319,24 @@
 	}
 }
 
+#ifndef MODULE
+
+static int __init bttv_card_setup(char *str)
+{
+	int i,number,res = 2;
+
+	for (i = 0; res == 2 && i < BTTV_MAX; i++) {
+		res = get_option(&str,&number);
+		if (res)
+			card[i] = number;
+	}
+	return 1;
+}
+
+__setup("bttv_card=", bttv_card_setup);
+
+#endif /* not MODULE */
+
 /*
  * Local variables:
  * c-basic-offset: 8
--- linux.orig/drivers/media/video/bttv-driver.c	Mon Nov 20 02:07:47 2000
+++ linux/drivers/media/video/bttv-driver.c	Mon Nov 20 02:59:10 2000
@@ -3100,6 +3100,24 @@
 module_init(bttv_init_module);
 module_exit(bttv_cleanup_module);
 
+#ifndef MODULE
+
+static int __init bttv_radio_setup(char *str)
+{
+	int i,number,res = 2;
+
+	for (i = 0; res == 2 && i < BTTV_MAX; i++) {
+		res = get_option(&str,&number);
+		if (res)
+			radio[i] = number;
+	}
+	return 1;
+}
+
+__setup("bttv_radio=", bttv_radio_setup);
+
+#endif /* not MODULE */
+
 /*
  * Local variables:
  * c-basic-offset: 8

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
