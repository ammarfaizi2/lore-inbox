Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274630AbRIYLDK>; Tue, 25 Sep 2001 07:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274631AbRIYLDB>; Tue, 25 Sep 2001 07:03:01 -0400
Received: from [195.66.192.167] ([195.66.192.167]:55568 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S274630AbRIYLCy>; Tue, 25 Sep 2001 07:02:54 -0400
Date: Tue, 25 Sep 2001 14:00:23 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1619283678.20010925140023@port.imtp.ilyichevsk.odessa.ua>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux VM design
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi VM folks,

I'd like your comments on this (rather simplistic) hypothetic
VM description. If you know what's wrong with it, please tell me.


Ram page can be:

free
        Not used by anything.

clean non-backed
        Initially allocated page. All such pages share
        global zero-filled readonly page. On write COW magic
        is making a dirty non-backed copy
        
dirty non-backed
        This ram page have copy neither in swap nor in fs.
        Under light i/o load page laundering machinery
        _may_ allocate swap for it and write it back.
        Only after a timeout. No point in writing back
        too early/too often. This laundering can be
        turned off completely without much harm.

clean swap-backed
        This ram page has a copy on swap. It is not modified
        (either swapped in or is already laundered)
        Note: as soon as it gets dirty, it becomes
        dirty *non-backed* and swap page is freed
        
dirty swap-backed
        This ram page was modified some time ago, become
        dirty non-backed, and is being written back right now
        to newly allocated swap page (laundering or
        (evicting LRU ram page under memory pressure)).
        A temporary stage. Turns clean swap-backed
        as soon as write completes.

clean fs-backed
        This ram page is mmapped from a file and is not modified
        or already written back
        
dirty fs-backed
        This ram page is mmapped from a file and is modified.
        It needs to be written back within reasonable timeout
        to keep fs data consistent


How LRU works
        
All non-free ram pages are in LRU list. Top ram page on the list
is the most recently accessed one. Bottom one is least recently
accessed one.

VM periodically scans all process pte's looking for 'accessed'
and 'dirty' bits, resets those bits, modifies page status:

Accessed bit set: Move ram page to top of LRU list.
Dirty bit set:
    clean non-backed  -  can't happen (global zero page is RO)
    dirty non-backed  -> dirty non-backed
    clean swap-backed -> dirty non-backed (note: swap page freed!)
    dirty swap-backed -> dirty non-backed (note: complicated case. See below)
    clean fs-backed   -> dirty fs-backed
    dirty fs-backed   -> dirty fs-backed

Complicated case:
We are writing ram page to swap either due to:
1) Evicting LRU ram page under memory pressure
2) Laundering ram page under light io load
and page gets accessed/dirtied by some process.
In first case we are in deep trouble. To prevent this we must
unmap ram page from all processes before evicting.
In second case we are fine, however, laundering io is wasted.
Ram page should become dirty non-backed again and moved
to top of LRU list, swap page freed.


Ram page eviction

We evict ram pages when we have no free ram pages and
we have a memory request:
1) a process accesses not-present (swapped out) page
2) a process accesses not-present page mmaped to a file
3) a process writes to clean non-backed ram page and COW needs
   new ram page to make a copy

Rate of such evictions is a good measure of mem pressure.

We evict ram page from the bottom of LRU list by unmapping it from
all processes, writing back to fs or allocating swap and writing back
to swap if it is dirty and using freed ram page to fulfill memory
request.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


