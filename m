Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVAGAJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVAGAJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVAGAJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:09:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:50127 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261889AbVAGAIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:08:09 -0500
Date: Thu, 6 Jan 2005 16:12:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] kernel/printk.c  lockless access
Message-Id: <20050106161241.11a8d07c.akpm@osdl.org>
In-Reply-To: <20050106195812.GL22274@austin.ibm.com>
References: <20050106195812.GL22274@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas <linas@austin.ibm.com> wrote:
>
> I was wondering if you could see your way to accepting the attached
> patch, which provides access to the syslog buffer pointers.
> 
> The basic idea is that if a system has crashed, it can be handy to
> be able to view the contents of the syslog buffer.  Unfortunately,
> this is currently hard to do.
> 
>  --  char __log_buf[] is declared static in printk.c, so it cannot
>      be found in the ksyms table.
> 
>  -- do_syslog() uses spinlocks to protect the data structure, and
>     so will typically deadlock if called.
> 
> The 'fix' is to provide a routine that simply returns the pointers
> to the log buffer.  
> 
> I'd be thrilled to have this patch accepted ... 

We faced the same problem in the Digeo kernel.  When the kernel oopses we
want to grab the last kilobyte or so of the printk buffer and stash it into
nvram.  We did this via a function which copies the data rather than
exporting all those variables, which I think is a nicer and more
maintainable approach:

/** get_printk_state - read the printk log buffer state
 *
 * @how_far_back: how many bytes back-in-time to look
 *
 * get_printk_state() gives the caller the current printk
 * log buffer head index, for later use by get_printk_buffer()
 * The index is offset by @how_far_back, which allows the caller
 * to look at previously-emitted information.  Negative values of
 * how_far_back don't make sense.
 */
int get_printk_state(int how_far_back)
{
	return (log_end - how_far_back) & LOG_BUF_MASK;
}

/** get_printk_buffer - read bytes from the printk buffer
 *
 * get_printk_buffer() will copy some bytes from the printk
 * ring buffer into the caller's buffer.
 *
 * @buf - the caller's buffer.  Bytes are written here.
 * @len - the amount of space at *@buf
 * @start_at - where in the log buffer to start copying out
 * data.  Presumably from a previous get_printk_state() call.
 *
 * get_printk_buffer() does not place a null at the end of *@buf
 *
 * get_printk_state() returns the number of bytes which it wrote
 * to *@buf.
 */
int get_printk_buffer(char *buf, int len, int start_at)
{
	int count;
	int at = start_at;

	for (count = 0; count < len; count++, at++) {
		if ((at & LOG_BUF_MASK) == (log_end & LOG_BUF_MASK))
			break;
		buf[count] = LOG_BUF(at);
	}
	return count;
}

(all available in a horrendous tarball at
http://www.digeo.com/assets/datasheets/digeo-mc1-2.0.8-mods.tar.bz2)

You want to cook up something like that?  (That's 2.4 code, and might need
work for 2.6 changes).


