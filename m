Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVBOQLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVBOQLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVBOQJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:09:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:41962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261772AbVBOQII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:08:08 -0500
X-Authenticated: #26200865
Message-ID: <42121EC5.8000004@gmx.net>
Date: Tue, 15 Feb 2005 17:09:41 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Norbert Preining <preining@logic.at>
CC: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at>
In-Reply-To: <20050215125555.GD16394@gamma.logic.tuwien.ac.at>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining schrieb:
> On Mon, 14 Feb 2005, Pavel Machek wrote:
> 
>>(1) systems where video state is preserved over S3.
>>
>>(2) systems where it is possible to call video bios during S3
>>  resume. Unfortunately, it is not correct to call video BIOS at that
>>  point, but it happens to work on some machines. Use
>>  acpi_sleep=s3_bios.
>>
>>(3) systems that initialize video card into vga text mode and where BIOS
>>  works well enough to be able to set video mode. Use
>>  acpi_sleep=s3_mode on these.
>>
>>(4) on some systems s3_bios kicks video into text mode, and
>>  acpi_sleep=s3_bios,s3_mode is needed.
>>
>>(5) radeon systems, where X can soft-boot your video card. You'll need
>>  patched X, and plain text console (no vesafb or radeonfb), see
>>  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html.
>>
>>(6) other radeon systems, where vbetool is enough to bring system back
>>  to life. Do vbetool vbestate save > /tmp/delme; echo 3 > /proc/acpi/sleep;
>>  vbetool post; vbetool vbestate restore < /tmp/delme; setfont
>>  <whatever>, and your video should work.
>>
>>Acer TM 800			vga=normal, X patches, see webpage (5)
> 
> 
> 
> Acer TM 650 (Radeon M7)
> 
> vga=normal plus boot-radeon (webpage(5)) works to get text console
> back. But switching to X freezes the computer completely.

Please try method (6). It should work perfectly because it is the successor
for method (5) and works even without special patches for X.


> X from debian sid. 
> XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-10 20041215174925 fabbione@fabbione.net)
> Release Date: 15 August 2003
> X Protocol Version 11, Revision 0, Release 6.6
> Build Operating System: Linux 2.4.26 i686 [ELF] 
> Build Date: 15 December 2004
> 
> 
> I would like to get X running to, but there are no traces in the logfile
> whatsoever to be seen. Pity.

First, boot into X and run the following script ONCE:
#!/bin/bash
statedir=/root/s3/state
mkdir -p $statedir
chvt 2
sleep 1
vbetool vbestate save >$statedir/vbe


To suspend and resume properly, call the following script as root:
#!/bin/bash
statedir=/root/s3/state
curcons=`fgconsole`
fuser /dev/tty$curcons 2>/dev/null|xargs ps -o comm= -p|grep -q X && chvt 2
cat /dev/vcsa >$statedir/vcsa
sync
echo 3 >/proc/acpi/sleep
sync
vbetool post
vbetool vbestate restore <$statedir/vbe
cat $statedir/vcsa >/dev/vcsa
rckbd restart
chvt $[curcons%6+1]
chvt $curcons


Unless you change your grahics card or other hardware configuration,
the state once saved will be OK for every resume afterwards.
NOTE: The "rckbd restart" command may be different for your
distribution. Simply replace it with the command you would use to
set the fonts on screen.


> So it seems that my laptop does not fall in any of these categories.

Please try my scripts and resport back.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
