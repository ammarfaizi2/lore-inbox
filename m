Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284853AbRLURbW>; Fri, 21 Dec 2001 12:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284731AbRLURbM>; Fri, 21 Dec 2001 12:31:12 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48654 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284874AbRLURbF>; Fri, 21 Dec 2001 12:31:05 -0500
Date: Fri, 21 Dec 2001 15:30:19 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Greg KH <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: oops in mm/memory.c remap_page_range() in 2.2.20
In-Reply-To: <20011221091646.C21051@kroah.com>
Message-ID: <Pine.LNX.4.33L.0112211527590.28489-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Greg KH wrote:
> On Fri, Dec 21, 2001 at 09:05:11AM -0800, Greg KH wrote:
> > Running "cvs update" on a 2.2.20 kernel with 16Mb of real memory I got
> > the following oops:
>
> Sorry, had /boot/System.map pointing to the wrong place, this is the
> correct symbols:

> >>EIP; c01194a0 <vmtruncate_list+c/a8>   <=====

OK, lets take a look at the code in memory.c, first at line 736:

static void vmtruncate_list(struct vm_area_struct *mpnt, unsigned long
offset)
{
        do {
                struct mm_struct *mm = mpnt->vm_mm;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is the line where the system oopses, so vmtruncate_list
is being called with mpnt==0x00000002

Time to take a step back and look in vmtruncate(), line 769:

        if (inode->i_mmap)
                vmtruncate_list(inode->i_mmap, offset);
        if (inode->i_mmap_shared)
                vmtruncate_list(inode->i_mmap_shared, offset);


This suggests that you have a single-bit error somewhere in RAM
and vmtruncate_list() simply should never have been called.

kind regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

