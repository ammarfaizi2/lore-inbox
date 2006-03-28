Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWC1D7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWC1D7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWC1D7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:59:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750950AbWC1D7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:59:09 -0500
Date: Mon, 27 Mar 2006 19:59:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
Message-Id: <20060327195905.7f666cb5.akpm@osdl.org>
In-Reply-To: <1143510828.1792.353.camel@mindpipe>
References: <1143510828.1792.353.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> I am simply trying to run a Gnome desktop (Gnome 2.14, Evolution,
> Firefox, gtk-gnutella usually open) without swapping or getting OOM
> killed.
> 
> I have to set the swappiness to 0 or else I get swap storms when simply
> browsing the web and reading my mail.  I think this is insane as I have
> 512MB of RAM.  It seems as if the kernel will OOM kill firefox rather
> than shrink the file cache!

No, there is little pagecache left.

> What is the problem here?  Is the modern Linux desktop really too
> bloated to run in half a gig of RAM, or is the kernel overzealous with
> its OOM killing?

Looks like it.

> ...
> 
> rlrevell@mindpipe:~$ vmstat 1
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  2  0 248992   5612   4072  75268    3    2    41    49   12    33 82  4 14  1
>  0  0 248992   5364   4084  75300    0    0     0   128 1273   640 34  3 63  0
>  0  0 248992   5356   4084  75464    0    0     0     0 1257   611 23  4 73  0
>  0  0 248992   5356   4084  75496    0    0     0     0 1292   635 21  2 77  0
>  0  0 248992   5356   4084  75532    0    0     0     0 1277   599 22  3 75  0
>  0  0 248992   5356   4084  75532    0    0     0     0 1270   610 23  2 75  0
>  1  0 248992   5232   4092  75564    0    0     0   200 1274   596 21  2 77  0
>  0  0 248992   5232   4092  75564    0    0     0     0 1280   648 22  2 76  0
>  0  0 248992   5108   4092  75696    0    0     0     0 1296   621 21  4 75  0

70-odd MB in pagecache.  Probably a lot of this is mmapped into process
pagetables and by setting swappiness==0 you've basically told the kernel
that this memory is to be preserved.

> rlrevell  1792  4.1 37.9 320340 166724 ?       Sl   Mar21 353:33 evolution --component=mail
> rlrevell  2298  9.2 18.9 200556 83112 ?        Sl   15:16  30:55 /usr/lib/firefox/firefox-bin -a firefox
> rlrevell  1794  0.0  2.1  92704  9344 ?        Sl   Mar21   0:47 /usr/lib/evolution/evolution-data-server-1.6 --oaf-activate-iid=OAFIID:GNOME_Evolution_DataServer_InterfaceCheck --oaf-ior-fd=41
> rlrevell  1805  0.0  0.6  65236  2740 ?        Sl   Mar21   0:06 /usr/lib/evolution/2.6/evolution-alarm-notify --oaf-activate-iid=OAFIID:GNOME_Evolution_Calendar_AlarmNotify_Factory:2.6 --oaf-ior-fd=43
> root      2295 70.3  4.5  58160 19908 tty7     Ss+  Mar18 9207:34 /usr/bin/X :0 -br -audit 0 -auth /var/lib/gdm/:0.Xauth -nolisten tcp vt7
> rlrevell  2759  0.0  1.0  57716  4832 ?        Ssl  Mar18   2:48 nautilus --sm-config-prefix /nautilus-kFkhxG/ --sm-client-id 106281f446000113283283500000043730002 --screen 0 --no-default-window
> rlrevell  2749  0.0  0.5  33720  2404 ?        Sl   Mar18   3:09 /usr/lib/control-center/gnome-settings-daemon --oaf-activate-iid=OAFIID:GNOME_SettingsDaemon --oaf-ior-fd=25

Much porkiness.

/proc/meminfo is very useful for obtaining a top-level view of where all
the memory's gone to.  I'd tentatively say that your options are to put up
with the swapping or find a new mail client.

