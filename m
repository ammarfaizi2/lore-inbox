Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVBRJGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVBRJGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 04:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVBRJGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 04:06:52 -0500
Received: from ns.suse.de ([195.135.220.2]:57819 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261305AbVBRJGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 04:06:49 -0500
Message-ID: <421506FC.3060909@suse.de>
Date: Thu, 17 Feb 2005 22:05:00 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       dtor_core@ameritech.net
Subject: Re: Swsusp, resume and kernel versions
References: <200502162346.26143.dtor_core@ameritech.net>	 <1108617332.4471.33.camel@desktop.cunningham.myip.net.au>	 <200502170038.30033.dtor_core@ameritech.net> <1108627778.4471.54.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1108627778.4471.54.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

> If the mistakenly booted kernel isn't suspend enabled, however, you need
> a more generic method of removing the image, such as mkswapping the
> storage device. This is what I was speaking of.

The following code is used in the SUSE bootscripts to do exactly this:

----------------------------------------------------
get_swap_id() {
    local line;
    fdisk -l | while read line; do
        case "$line" in
        /*Linux\ [sS]wap*) echo "${line%% *}"
        esac
    done
}

check_swap_sig () {
    local part="$(get_swap_id)"
    local where what type rest p c
    while read  where what type rest ; do
        test "$type" = "swap" || continue
        c=continue
        for p in $part ; do
            test "$p" = "$where" && c=true
        done
        $c
        case "$(dd if=$where bs=1 count=6 skip=4086 2>/dev/null)" in
        S1SUSP|S2SUSP) mkswap $where
        esac
    done < /etc/fstab
}
---------------------------------------------------------------------

This invalidates the suspend signature if the kernel has not already
done it. It probably does not cover the softwaresuspend2 signature but
that should be trivial to add.

Regards,

  Stefan

