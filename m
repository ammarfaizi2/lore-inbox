Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317621AbSGFGUF>; Sat, 6 Jul 2002 02:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSGFGUE>; Sat, 6 Jul 2002 02:20:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53009 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317621AbSGFGUE>;
	Sat, 6 Jul 2002 02:20:04 -0400
Message-ID: <3D268E19.B68559F6@zip.com.au>
Date: Fri, 05 Jul 2002 23:28:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
References: <Pine.LNX.4.44L.0207060228460.8346-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> Hi,
> 
> Almost the same patch as before, except this one has had
> a few hours of testing by Andrew Morton and two bugs have
> been ironed out, most notably the truncate_complete_page()
> race.  This patch is probably safe since Andrew got bored
> when no new bugs showed up ...
> 

The box died, but not due to rmap.  We have a lock ranking
bug:

        do_exit
        ->mmput
          ->exit_mmap                           page_table_lock
            ->removed_shared_vm_struct
              ->lock_vma_mappings               i_shared_lock

versus

        do_truncate
        ->notify_change
          ->inode_setattr
            ->vmtruncate                        i_shared_lock
              ->vmtruncate_list
                ->zap_page_range                page_table_lock

It seems that in 2.5.16, a call to remove_shared_vm_struct() was
added to exit_mmap(), inside mm->page_table_lock.

That ranking conflicts with truncate.

-
