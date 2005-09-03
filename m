Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVICS5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVICS5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 14:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVICS5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 14:57:24 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:49540 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751188AbVICS5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 14:57:23 -0400
Message-ID: <4319F20B.70107@gmail.com>
Date: Sat, 03 Sep 2005 20:57:15 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Request for review
References: <NBBBIHMOBLOHKCGIMJMDEEGLEKAA.g.tomassoni@libero.it>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDEEGLEKAA.g.tomassoni@libero.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni napsal(a):

>Dears,
>
>I wrote a first release of a SAR helper module for Linux 2.6.x.
>
>It is conceptually similar to the Duncan Sands' usb_atm module, but it is not constrained to usb devices and is a bit different from it in its implementation details.
>
>It seems to me that scores some points in this:
>
>- supplies a coherent interface which allows the device driver to bypass
>	almost any interaction with the atm layer;
>
>- supports ATM header&hec check, correction and generation, which is
>	most useful for dumb atm devices (ie: most ADSL modems);
>
>- supports automatic and fast routing of received cells to destinating
>	vcc;
>
>- actually supports AALraw, AAL0 and AAL5;
>
>- aal decoding/encoding routines are designed as atmsar plug-ins, so
>	that further types may easily be supported;
>
>- implements speed- and memory-concerned techniques for per-vcc
>	decoding;
>
>- allows using dma-streaming techniques in sending cells to device;
>
>- supports tx buffer adjusting against device needs;
>
>- avoids vcc open/close paradigm handling in device driver;
>
>- yields a uniform view to SAR status in /proc.
>
>
>I'm contacting you firstly because I would like to hear your point of view about the whole idea (am I reinventing the wheel?), then because I would like to have my code reviewed, and lastly because I have some question about the matter.
>
>I prepared the SAR module as a patch against the Linux 2.6.12.3 kernel tree. It is attached to this message as a unified diff.
>
>Also, in order to allow you to evaluate it, I prepared a driver adopting the SAR module's API for the Globespan Pulsar ADSL PCI card. This driver is made after the one from Guy Ellis (see http://adsl4linux.no-ip.org/pulsar.html for further reference). My version is a two-part driver: a GPL one ( http://www.tomassoni.biz/download/pulsar/pulsaradsl-1.0.1-source.tar.bz2 ) and a proprietary library ( http://www.tomassoni.biz/download/pulsar/libpulsar_fw.a.bz2 ) which shall be decompressed and put in the pulsaradsl-1.0.1 directory in order to build the driver. The libpulsar_fw.a is the one for GCC 3. If you need a version of this library for another GCC flavor, please see the above reported Ellis' pulsar site.
>
>Note also that I'm allowing you to download a copy of the libpulsar_fw.a library only for the purpose of evaluating the SAR module: it is not meant to be used otherway.
>
>My intention, if the maintainer of the ATM stack under Linux (Chas Williams) and the author of the usb_atm module (Duncan Sands) agree, is to merge the atmsar module into the linux tree, thereby replacing the atm+sar code in the Verrept-Sands' atm_usb module, which will then contain only the usb handling code and eventually will relay on the atmsar module for its atm+sar ops. I'm also looking for help by Sands to do this. Also, it could be interesting to have the Ellis' driver use this module, as the Pulsar PCI ADSL card is actually the only ADSL PCI modem of which I'm aware.
>  
>
+void           atmsar_rx_decode_52bytes(atmsar_dev_t* dev, const void* 
cell)
why the spaces between void and function name? The readability of the 
code is bad :(.
+{ sarDecode(dev, ntohl(*(unsigned*)cell), &((char*)cell)[4]); }
and
+static inline void dumpCell(char* dst, const ATM_CELL* cell) {
What's this? See CodingStyle, chapter 3.

CodingStyle, chapter 2:
-The limit on the length of lines is 80 columns and this is a hard limit.-
Please keep to it.

Fix this:
/l/latest/xxx/drivers/atm/sar.c:254:5: warning: "DBG" is not defined
/l/latest/xxx/drivers/atm/sar.c:307:5: warning: "DBG" is not defined

Remove trailing spaces from the end of lines, please.

        return(sar);
no parens around return value.

                if(len < ATM_CELL_PAYLOAD)
space between if and (

        atmsar_vcc_t *sar = (atmsar_vcc_t*)kmalloc(sizeof(sar), GFP_KERNEL);
this should be sizeof(*sar)
        if(sar != NULL)
                memset(sar, 0, sizeof(*sar));
use kzalloc instead of this piece (you may need to upgrade your kernel 
to some latest version)

        struct sk_buff* skbIn
* after space, not before

        int i;
        atm_dev_deregister(dev->atmdev);
        for(i = 0; i < ATMSAR_N_HASHVCCS; ++i)
space between for and (
                while(dev->vccs_hash[i] != NULL)
                        atmClose(dev->vccs_hash[i]->vcc);
unsigned int is better if you don't need to count in negative, this is 
only hint.

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

