Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWCUGjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWCUGjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 01:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWCUGjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 01:39:10 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:29501 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbWCUGjJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 01:39:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N7OWQVQ/jOPYNkNxu6F7igukCH8OLpOHuYL1Jxlqtuom0AgsKv8cQSxoXiDyJtPUK2GhfQQW/VXDXhwzsRIoQ9I97e0Lo9x/uysxy/2CQeaO78ZNl8YsS1CoAemi6+Xaa6XVP9FSCcK1GgrFZri/VT3wknVQBFkjq8iA7ToXQlE=
Message-ID: <38c09b90603202239l66e1d4bds33c2023f85587299@mail.gmail.com>
Date: Tue, 21 Mar 2006 14:39:08 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
In-Reply-To: <38c09b90603161846n47b5d47fnc6b4d4b9ff2d078b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
	 <20060314103854.GC32065@lug-owl.de>
	 <38c09b90603142030o7092a39aq8ace7758972ce09a@mail.gmail.com>
	 <200603152253.24194.daniel.ritz-ml@swissonline.ch>
	 <38c09b90603161846n47b5d47fnc6b4d4b9ff2d078b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/06, Lanslott Gish <lanslott.gish@gmail.com> wrote:
> On 3/16/06, Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:
> that just can't be right. you probably mean
> +       *y = pkt[3] | ((pkt[4] & 0x0F) << 8);
>
> otherwise you mask out bits 4-7. but you want to limit it to 12 bits...
> (btw. no need for the & 0xFF mask since *pkt is char)
>
>
> you are right, sorry for my fault. the truely way is
>
> +       *x = (pkt[1] & 0xFF) | ((pkt[2] & 0x0F) << 8);
> +       *y = (pkt[3] & 0xFF) | ((pkt[4] & 0x0F) << 8);
>
> still need 12 bits( 0x0FFF) and the masks to avoid get negative.
>


OK, Here we go~
i try your patch:

+	printk("pkg_dbg,%x,%x,%x,%x\n",pkt[1],pkt[2],pkt[3],pkt[4]);
+       *x = pkt[1] | ((pkt[2] & 0x0F) << 8);
+       *y = pkt[3] | ((pkt[4] & 0x0F) << 8);
+       printk("touchset_dbg,%x,%x,%d,%d\n",*x,*y,*x,*y);

and here is parts of the /var/log/message (raw data from 4 corners of
the panel):

---------------------------------------------------------------------------
Mar 21 14:33:52 localhost kernel: input: PANJIT TouchSet USB Touch
Panel as /class/input/input12
Mar 21 14:33:55 localhost input.agent[10300]:      joydev: already loaded
Mar 21 14:34:38 localhost kernel: pkg_dbg,fffffff9,1,2d,e
Mar 21 14:34:38 localhost kernel: touchset_dbg,fffffff9,e2d,-7,3629
Mar 21 14:34:38 localhost kernel: pkg_dbg,fffffff8,1,2c,e
Mar 21 14:34:38 localhost kernel: touchset_dbg,fffffff8,e2c,-8,3628
Mar 21 14:34:38 localhost kernel: pkg_dbg,fffffff4,1,2d,e
Mar 21 14:34:38 localhost kernel: touchset_dbg,fffffff4,e2d,-12,3629
Mar 21 14:34:38 localhost kernel: pkg_dbg,fffffff2,1,2d,e
Mar 21 14:34:38 localhost kernel: touchset_dbg,fffffff2,e2d,-14,3629
Mar 21 14:34:38 localhost kernel: pkg_dbg,fffffff1,1,2e,e
Mar 21 14:34:38 localhost kernel: touchset_dbg,fffffff1,e2e,-15,3630
Mar 21 14:34:39 localhost kernel: pkg_dbg,20,3,ffffffae,2
Mar 21 14:34:39 localhost kernel: touchset_dbg,320,ffffffae,800,-82
Mar 21 14:34:39 localhost kernel: pkg_dbg,20,3,ffffffae,2
Mar 21 14:34:39 localhost kernel: touchset_dbg,320,ffffffae,800,-82
Mar 21 14:34:39 localhost kernel: pkg_dbg,1d,3,ffffffb2,2
Mar 21 14:34:39 localhost kernel: touchset_dbg,31d,ffffffb2,797,-78
Mar 21 14:34:39 localhost kernel: pkg_dbg,1b,3,ffffffb4,2
Mar 21 14:34:39 localhost kernel: touchset_dbg,31b,ffffffb4,795,-76
Mar 21 14:34:41 localhost kernel: pkg_dbg,ffffffa4,c,75,d
Mar 21 14:34:41 localhost kernel: touchset_dbg,ffffffa4,d75,-92,3445
Mar 21 14:34:41 localhost kernel: pkg_dbg,ffffffa4,c,7a,d
Mar 21 14:34:41 localhost kernel: touchset_dbg,ffffffa4,d7a,-92,3450
Mar 21 14:34:41 localhost kernel: pkg_dbg,ffffffa2,c,ffffff81,d
Mar 21 14:34:41 localhost kernel: touchset_dbg,ffffffa2,ffffff81,-94,-127
Mar 21 14:34:41 localhost kernel: pkg_dbg,ffffff9d,c,ffffff87,d
Mar 21 14:34:41 localhost kernel: touchset_dbg,ffffff9d,ffffff87,-99,-121
Mar 21 14:34:42 localhost kernel: pkg_dbg,ffffff86,d,ffffffcf,1
Mar 21 14:34:42 localhost kernel: touchset_dbg,ffffff86,ffffffcf,-122,-49
Mar 21 14:34:42 localhost kernel: pkg_dbg,74,d,ffffffd7,1
Mar 21 14:34:42 localhost kernel: touchset_dbg,d74,ffffffd7,3444,-41
Mar 21 14:34:42 localhost kernel: pkg_dbg,58,d,ffffffe0,1
Mar 21 14:34:42 localhost kernel: touchset_dbg,d58,ffffffe0,3416,-32
----------------------------------------------------------------------


is anything weird?
and i try my codes:

+	printk("pkg_dbg,%x,%x,%x,%x\n",pkt[1],pkt[2],pkt[3],pkt[4]);
+       *x = (pkt[1] & 0xFF) | ((pkt[2] & 0x0F) << 8);
+       *y = (pkt[3] & 0xFF) | ((pkt[4] & 0x0F) << 8);
+	printk("touchset_dbg,%x,%x,%d,%d\n",*x,*y,*x,*y);

and here is the /var/log/message (the same, 4 coners):

---------------------------------------------------------------------
Mar 21 14:38:14 localhost kernel: usbcore: deregistering driver usbtouchscreen
Mar 21 14:38:14 localhost kernel: input: PANJIT TouchSet USB Touch
Panel as /class/input/input14
Mar 21 14:38:14 localhost kernel: usbcore: registered new driver usbtouchscreen
Mar 21 14:38:17 localhost input.agent[10688]:      joydev: already loaded
Mar 21 14:38:38 localhost kernel: pkg_dbg,5,2,6,e
Mar 21 14:38:38 localhost kernel: touchset_dbg,205,e06,517,3590
Mar 21 14:38:38 localhost kernel: pkg_dbg,fffffffe,1,13,e
Mar 21 14:38:38 localhost kernel: touchset_dbg,1fe,e13,510,3603
Mar 21 14:38:38 localhost kernel: pkg_dbg,fffffff0,1,22,e
Mar 21 14:38:38 localhost kernel: touchset_dbg,1f0,e22,496,3618
Mar 21 14:38:39 localhost kernel: pkg_dbg,ffffffd5,2,ffffff99,2
Mar 21 14:38:39 localhost kernel: touchset_dbg,2d5,299,725,665
Mar 21 14:38:39 localhost kernel: pkg_dbg,ffffffd2,2,ffffff9a,2
Mar 21 14:38:39 localhost kernel: touchset_dbg,2d2,29a,722,666
Mar 21 14:38:39 localhost kernel: pkg_dbg,ffffffce,2,ffffff9c,2
Mar 21 14:38:39 localhost kernel: touchset_dbg,2ce,29c,718,668
Mar 21 14:38:39 localhost kernel: pkg_dbg,ffffffc9,2,ffffff9e,2
Mar 21 14:38:39 localhost kernel: touchset_dbg,2c9,29e,713,670
Mar 21 14:38:41 localhost kernel: pkg_dbg,6e,d,ffffffec,d
Mar 21 14:38:41 localhost kernel: touchset_dbg,d6e,dec,3438,3564
Mar 21 14:38:41 localhost kernel: pkg_dbg,71,d,ffffffed,d
Mar 21 14:38:41 localhost kernel: touchset_dbg,d71,ded,3441,3565
Mar 21 14:38:41 localhost kernel: pkg_dbg,72,d,ffffffed,d
Mar 21 14:38:41 localhost kernel: touchset_dbg,d72,ded,3442,3565
Mar 21 14:38:41 localhost kernel: pkg_dbg,71,d,ffffffed,d
Mar 21 14:38:41 localhost kernel: touchset_dbg,d71,ded,3441,3565
Mar 21 14:38:41 localhost kernel: pkg_dbg,5f,d,ffffffec,d
Mar 21 14:38:41 localhost kernel: touchset_dbg,d5f,dec,3423,3564
Mar 21 14:38:42 localhost kernel: pkg_dbg,ffffffac,d,ffffffd0,1
Mar 21 14:38:42 localhost kernel: touchset_dbg,dac,1d0,3500,464
Mar 21 14:38:42 localhost kernel: pkg_dbg,ffffffae,d,ffffffd0,1
Mar 21 14:38:42 localhost kernel: touchset_dbg,dae,1d0,3502,464
Mar 21 14:38:42 localhost kernel: pkg_dbg,ffffffa3,d,ffffffdb,1
Mar 21 14:38:42 localhost kernel: touchset_dbg,da3,1db,3491,475
Mar 21 14:38:42 localhost kernel: pkg_dbg,ffffff92,d,ffffffe6,1
Mar 21 14:38:42 localhost kernel: touchset_dbg,d92,1e6,3474,486
---------------------------------------------------------------------
i think my codes is correct.

so, make sure that your device differ with mine. :)


regards,

Lanslott Gish
--
L.G, Life's Good~
