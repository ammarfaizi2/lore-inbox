Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbTDARjA>; Tue, 1 Apr 2003 12:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbTDARjA>; Tue, 1 Apr 2003 12:39:00 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:36085 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S262694AbTDARi5>; Tue, 1 Apr 2003 12:38:57 -0500
Date: Tue, 1 Apr 2003 12:50:20 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap-related questions
Message-ID: <20030401125020.E25225@redhat.com>
References: <20030331125548.D20730@redhat.com> <20030401032546.17891.qmail@web20002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030401032546.17891.qmail@web20002.mail.yahoo.com>; from theonetruekenny@yahoo.com on Mon, Mar 31, 2003 at 07:25:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 07:25:46PM -0800, Kenny Simpson wrote:
> --- Benjamin LaHaise <bcrl@redhat.com> wrote:
> > No.  You must use msync().
> 
> > Note that fsync() after
> > munmap() will flush the 
> > pages to disk under Linux.
> Sweet!  Paydirt!  Is this documented/guaranteed to
> continue to work for a while?
> Is this true for all non-mmap()ed dirty buffers for a
> given file?

It's only true for the pages the munmap() removes from the process' page 
tables: the act of unmapping them transfers the dirty bit from the page 
tables into the page cache where fsync() acts on them.

> Just to restate what you said:
> - if part of a file is mmap()ed, msync() MUST be used
> to sync it.
> - any non-mmap()ed portions are synched with fsync().

Pretty much.

> I'm assuming this is a per-process thing.  i.e. The
> above is true regardless of what other processes are
> doing (e.g. even if another process has the same file
> mmap()'d, I don't care).

Right.  Other processes are responsible for managing their own syncing of 
dirty bits to disk at the appropriate times.  The one case this breaks down 
on is when the mmap()'d file is on NFS -- the reordering there can result in 
writebacks from mmap()s occuring in unexpected ways.  But then, nobody trusts 
their data to NFS, right?  ;-)

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
