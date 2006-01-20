Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWATTHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWATTHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWATTHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:07:07 -0500
Received: from ns1.suse.de ([195.135.220.2]:18660 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932081AbWATTGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:06:55 -0500
Date: Fri, 20 Jan 2006 20:06:53 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060120190653.GE24401@hasse.suse.de>
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru> <20060118224953.GA31364@hasse.suse.de> <43CF6170.3050608@sw.ru> <20060119100443.GD10267@hasse.suse.de> <43CF693D.4020104@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43CF693D.4020104@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, Kirill Korotaev wrote:

> CPU 1				CPU 2
> ~~~~~				~~~~~
> umount /dev/sda1
> generic_shutdown_super          shrink_dcache_memory()
> shrink_dcache_parent            dput dentry
> select_parent                   prune_one_dentry()
>                                 <<<< child is dead, locks are released,
>                                   but parent is still referenced!!! >>>>
> skip dentry->parent,
> since it's d_count > 0
> 
> message: BUSY inodes after umount...
>                                 <<< parent is left on dentry_unused list,
>                                    referencing freed super block >>>

I see. The problem is that dcache_lock is given up before dereferencing the
parent. But your patch seems to be wrong anyway IMHO. I'll post patches in a
seperate thread.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
