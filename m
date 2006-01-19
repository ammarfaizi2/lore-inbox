Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161311AbWASKEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWASKEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWASKEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:04:46 -0500
Received: from mail.suse.de ([195.135.220.2]:18379 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161311AbWASKEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:04:45 -0500
Date: Thu, 19 Jan 2006 11:04:44 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060119100443.GD10267@hasse.suse.de>
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru> <20060118224953.GA31364@hasse.suse.de> <43CF6170.3050608@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43CF6170.3050608@sw.ru>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, Kirill Korotaev wrote:

> This patch has nothing to do with vfsmount references and doesn't hide 
> anything. It just adds syncronization barrier between do_umount() and 
> shrink_dcache() since the latter can work with dentries/inodes without 
> holding locks.
> 
> So if you think there is something wrong with it, please, be more specific.
> 

You can only unmount a file system if there are no references to the vfsmount
object anymore. Since shrink_dcache*() is called after checking the refcount of
vfsmount while unmounting the file system, it isn't possible to hold a
reference to a dentry (and therefore call dput()) after this point in
time. Therefore your reference counting on the vfsmount is wrong which is the
root case for your problem of busy inodes.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
