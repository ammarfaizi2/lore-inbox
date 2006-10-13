Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWJMPTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWJMPTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWJMPTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:19:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32490 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751194AbWJMPTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:19:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=qr+EUUi6lPMhCB+Nkw25SY5B9xJHNNXSbefyRwn9e3mCOeiM0mAGn6CAY9PTHOIgF4sXajyCxZpVWzSck8QDZaOmcZ1RaCzUpI4VBD31ji2J2V2Mrw6yfgTvI9Kfgk5+WzaNp1fX899aFtbj4OQqiBN7FclXaYj8kH9b5SODiDY=
Message-ID: <452FAE74.1020500@googlemail.com>
Date: Fri, 13 Oct 2006 17:19:16 +0200
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: akpm@osdl.org
CC: neilb@suse.de, michal.k.k.piotrowski@gmail.com, rusty@rustcorp.com.au,
       "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: + convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
 added to -mm tree
References: <200610130506.k9D56YJY031111@shell0.pdx.osdl.net>
In-Reply-To: <200610130506.k9D56YJY031111@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

akpm@osdl.org wrote:
> The patch titled
> 
>      Convert cpu hotplug notifiers to use raw_notifier instead of blocking_notifier
> 
> has been added to the -mm tree.  Its filename is
> 
>      convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: Convert cpu hotplug notifiers to use raw_notifier instead of blocking_notifier
> From: Neil Brown <neilb@suse.de>
> 
> The use of blocking notifier by _cpu_up and _cpu_down in cpu.c has two
> problem.
> 
> 1/ An interaction with the workqueue notifier causes lockdep to spit a
>    warning.
> 
> 2/ A notifier could conceivable be added or removed while _cpu_up or
>    _cpu_down are in process.  As each notifier is called twice (prepare
>    then commit/abort) this could be unhealthy.
> 
> To fix to we simply take cpu_add_remove_lock while adding or removing
> notifiers to/from the list.
> 
> This makes the 'blocking' usage unnecessary as all accesses to cpu_chain
> are now protected by cpu_add_remove_lock.  So change "blocking" to "raw" in
> all relevant places.  This fixes 1.
> 

There is something really wrong with this patch (or my hardware).

echo shutdown > /sys/power/disk; echo disk > /sys/power/state
works fine for me on 2.6.19-rc1-g8770c018.

On 2.6.19-rc1-mm1 +
convert-cpu-hotplug-notifiers-to-use-raw_notifier-instead-of-blocking_notifier.patch
+ Neil's avoid_lockdep_warning_in_md.patch
(http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0642.html)
I get a lot of "end_request: I/O error, dev sda, sector 31834343" messages.

I checked sda with badblocks and everything seems to be fine
/sbin/badblocks -o /root/sda.badblocks -v /dev/sda
Sprawdzanie bloków od 0 do 156290904
Poszukiwanie wadliwych bloków (tylko odczyt): done
Przebieg zakoñczony, znaleziono 0 wadliwych bloków.
(/root/sda.badblocks is empty)

BTW. sda is a new Seagate SATA II HDD atached to ICH5 (SATA I) controller.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
