Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269281AbUISRFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbUISRFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269283AbUISRFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:05:30 -0400
Received: from imap.gmx.net ([213.165.64.20]:38301 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269281AbUISRE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:04:59 -0400
X-Authenticated: #1725425
Date: Sun, 19 Sep 2004 19:11:29 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-Id: <20040919191129.6f06293d.Ballarin.Marc@gmx.de>
In-Reply-To: <cikaf1$e60$1@sea.gmane.org>
References: <414C9003.9070707@softhome.net>
	<1095568704.6545.17.camel@gaston>
	<414D42F6.5010609@softhome.net>
	<20040919140034.2257b342.Ballarin.Marc@gmx.de>
	<414D96EF.6030302@softhome.net>
	<20040919171456.0c749cf8.Ballarin.Marc@gmx.de>
	<cikaf1$e60$1@sea.gmane.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 22:00:52 +0600
"Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:

> 
> OK. The fact is that, when mounting the root filesystem, the kernel can 
> (?) definitely say "there is no such device, and it's useless to wait 
> for it--so I panic". Is it possible to duplicate this logic in the case 
> with udev and modprobe? If so, it should be built into a common place 
> (either the kernel or into modprobe), but not into all apps.

Well, once  the system is running, the device might appear any time, so
waiting is hardly useless then.

In the past you did modprobe and afterwards tried to access the device. If
this succeeded, the device was created successfully, if not, something
went wrong, and your script returned an error code.
This approach has some problems.
The device is plugged in later on: "su" to root, re-run script. Not nice.
The script doesn't check properly for later errors: something breaks.

Now, the device is either autodetected or - when this is not possible
("legacy" devices) you have to modprobe manually.
If this succeeds, you are informed in dev.d. If it fails you are
"informed" by not being called in dev.d.

If I understand correctly, you wish do modprobe for a legacy device and
then know if this succeeded completely.
Simply choose a state-file in /var and write something like "not detected"
inside. Then do modprobe.
The other part of your script will wait in dev.d for the event. If it
arrives, the script will change the state file to "found" and do its work.
So, as long as the state is "not detected" you treat the device as not
present - just as if your old, synchronous script had returned an error
code. The advantage is, that if the device appears later on everything
will work automatically.

> 
> Then the "char-major" aliases were always broken, do I understand 
> correctly? Once we realize that, isn't it the time to mark the 
> "Automatic kernel module loading" in the kernel configuration as BROKEN 
> or OBSOLETE?

IIRC this feature is intended primarily for loadable kernel features and
pseudo devices, not "real" device drivers.

> 
> Yes. Now we have a lot of short scriptlets under /etc/dev.d. But I don't
> yet see how these scriptlets interact with each other.

You could use some state file if hotplug messages aren't enough, as
described above.

mfg
