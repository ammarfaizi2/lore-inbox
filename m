Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUAGTwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUAGTwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:52:15 -0500
Received: from lmdeliver01.st1.spray.net ([212.78.202.210]:23700 "EHLO
	lmdeliver01.st1.spray.net") by vger.kernel.org with ESMTP
	id S266319AbUAGTvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:51:55 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Valentijn Sessink <linux-kernel-1073394249@mail.v.sessink.nl>
Subject: Re: HiSax freezes 2.6.0-test11
Date: Wed, 7 Jan 2004 20:49:22 +0100
User-Agent: KMail/1.5.2
References: <20040106130518.GA1182@openoffice.nl>
In-Reply-To: <20040106130518.GA1182@openoffice.nl>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CLG//zaRr+ddGUl"
Message-Id: <200401072049.22628.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_CLG//zaRr+ddGUl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 06 January 2004 14:05, Valentijn Sessink wrote:
> Hello list,
>
> My 2.6.0-test11 "hisax" module freezes my PC, but seems to handle
> interrupts, as ICMP and keyboard leds keep functioning. I sent mail to
> kkeil and kai.germaschewski and to the ISDN mailing list, but no reply.
> I'm willing to test and/or hunt for the bug, but don't know where to
> look. As this interrupt behaviour seems rather specific, maybe someone
> could help me out where to look?

It also freezes on my PC... it seems very broken!
When I wrote to LKML asking for help Simon Cahuk <simon.cahuk@uni-mb.si> 
suggested me to try mISDN ( ftp.isdn4linux.de )
... and it seems to work (for me).

MORE INFO (quoted from Simon Cahuk)
_____________________________________________________________________
What you need:

- 2.6.0-test9-bk22 (or later) or 2.4.20 kernel? (or later)
- I4L patch for 2.6.0-test9-bk22 (patches cleanly test10 and test11)
- mISDN (mISDN-CVS tarball or mISDN direct from CVS server)
- supported ISDN card.

Download and extract the mISDN-CVS tarball from ftp.isdn4linux.de/snapshots.
Unpack it. 
Then make a symbolic link to your kernel source:

cd /usr/src
ln -sf your_kernel_source linux

Go to your mISDN source and run from there:
./std2kern

Patch your kernel (I4L patch):

cd /usr/src/linux
zcat path_to_the_I4L_patch.gz | patch -p1

This will copy the mISDN stuff to your kernel source. Please check that
your /usr/src/linux link exists before you run std2kern.

Configure your kernel as usually and enable the following:

CONFIG_ISDN_BOOL=y
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_MISDN_DRV=m
CONFIG_MISDN_MEMDEBUG=y
CONFIG_MISDN_AVM_FRITZ=y # if you have an AVM Fritz card
CONFIG_MISDN_HFCPCI=y # if you have a HFPCI card
CONFIG_MISDN_SPEEDFAX=y # if you have a SPEEDFAX card
CONFIG_MISDN_W6692=y # if you have a  W6692 card
CONFIG_MISDN_DSP=y

Reboot your machine and boot the new kernel. 

Here is a script (from Karsten) to load the modules:

#!/bin/sh
if [ $# -ge 1 ]; then
        DEBUG=$1
else
        DEBUG=0
fi
#INSMOD_PARA=-m
MEXT=.ko
cd /lib/modules/`uname -r`/kernel/drivers/isdn/hardware/mISDN
#modprobe capidrv
modprobe capi
insmod ${INSMOD_PARA} mISDN_core${MEXT} debug=${DEBUG} >/tmp/m_core.mod
insmod ${INSMOD_PARA} mISDN_l1${MEXT} debug=${DEBUG} >/tmp/m_l1.mod
insmod ${INSMOD_PARA} mISDN_l2${MEXT} debug=${DEBUG} >/tmp/m_l2.mod
insmod ${INSMOD_PARA} l3udss1${MEXT} debug=${DEBUG} >/tmp/m_l3u.mod
insmod ${INSMOD_PARA} mISDN_capi${MEXT} debug=${DEBUG} >/tmp/m_capi.mod
insmod ${INSMOD_PARA} mISDN_isac${MEXT} >/tmp/m_isac.mod
insmod ${INSMOD_PARA} avmfritz${MEXT} debug=${DEBUG} protocol=2 > /tmp/
avmfritz
.mod

Then mount capifs:
mkdir /dev/capi
mount -t capifs capifs /dev/capi


or add to fstab: 
capifs              /dev/capi       capifs          defaults                
0 
0

Now run pppd:

pppd call isdn/arcor.

If ps ax shows
<PID> ?        S      0:00 pppd call isdn/arcor

then kill pppd with kill -9 <PID> and run pppd again. Then should ps ax 
show:
<PID> capi/0   S      0:00 pppd call isdn/arcor. 
_____________________________________________________________________


Example of isdn/arcor file:
_____________________________________________________________________
With CAPI you use pppd. Edit your /etc/ppp/peers/isdn/arcor file and start:

pppd call isdn/arcor. You disconnect with killing the pppd pid.

My arcor:

sync
noauth
user USERNAME
plugin userpass.so
password PASSWORD
defaultroute
plugin capiplugin.so
number 088932331
protocol hdlc
ipcp-accept-local
ipcp-accept-remote
/dev/null

Capiplugin comes with capi4k-utils.

Simon
_____________________________________________________________________


BYE

-- 
	Paolo Ornati
	Linux v2.4.23

--Boundary-00=_CLG//zaRr+ddGUl
Content-Type: application/x-gzip;
  name="i4l-t9bk22.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="i4l-t9bk22.gz"

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

--Boundary-00=_CLG//zaRr+ddGUl--


