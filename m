Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264741AbUEaTJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbUEaTJh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 15:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUEaTJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 15:09:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:46488 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264741AbUEaTJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 15:09:35 -0400
Date: Mon, 31 May 2004 21:07:40 +0200
From: Stefan Seyfried <seife@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, ncunningham@linuxmail.org,
       cef-lkml@optusnet.com.au, linux-kernel@vger.kernel.org, rob@landley.net
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040531190740.GA27310@suse.de>
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz> <200405291905.20925.cef-lkml@optusnet.com.au> <40B85024.2040505@linuxmail.org> <20040529222308.GA1535@elf.ucw.cz> <20040531031743.0d7566e3.akpm@osdl.org> <20040531115049.GB28188@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531115049.GB28188@atrey.karlin.mff.cuni.cz>
X-Operating-System: SUSE LINUX Enterprise Server 9 (i586), Kernel 2.6.5-7.51-default
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 01:50:49PM +0200, Pavel Machek wrote:

> I believe stefan has some script that fixes swap signature using dd if
> it detects suspend signature...

this is in boot.swap initscript:

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

so if the user passes "noresume", the boot scripts fix up the mess :-)
An unconditional "mkswap" on the swap partition is a not-so-good idea
unless you check the ID of the partition from the partition table since
mkswap will create swap on anything you give him which may not always
be what you wanted.

Anyway, i think it is not too bad doing such cleanup stuff in userspace.

-- 
Stefan Seyfried                     QA / R&D mobile devices, SUSE LINUX AG

"Any ideas, John?"
"Well, surrounding thems out."
