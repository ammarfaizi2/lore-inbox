Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUE0FOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUE0FOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 01:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUE0FOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 01:14:15 -0400
Received: from pri-dns2.mtco.com ([207.179.200.252]:56289 "HELO
	pri-dns2.mtco.com") by vger.kernel.org with SMTP id S261418AbUE0FOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 01:14:10 -0400
From: Tom Felker <tcfelker@mtco.com>
To: Matthias Schniedermeyer <ms@citd.de>
Subject: Re: why swap at all?
Date: Thu, 27 May 2004 00:14:09 -0500
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B47D4C.6050206@yahoo.com.au> <20040526123740.GA14584@citd.de>
In-Reply-To: <20040526123740.GA14584@citd.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405270014.10096.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 May 2004 7:37 am, Matthias Schniedermeyer wrote:

> program to kernel: "i read ONCE though this file caching not useful".

Very true.  The system is based on the assumption that just-used pages are 
more useful that older pages, and it slows when this isn't true.  We need 
ways to tell the kernel whether the assumption holds.

(What follows are progressively more impossible ideas that I have no idea how 
to implement.)

O_STREAMING and a flag to not cache a file when it closes are a good start.  

It would also be useful to do this on a per-process basis.  For example, you 
could set a running shell so that its (and it's children's) files are 
O_STREAMING, and use that shell to launch your one-time greps.

Ulimit could set a limit on how much cache a process and its children could 
use.  (How much overhead this would this entail?)  That would take the place 
of the above, and it might also be useful for shell server admins who don't 
want one user trashing everyone's interactivity.

Most drastic would be to change the way to choose pages to throw out.  
Different processes or pages could have different priorities, so you could 
mark interactive processes as keepers even if you haven't used them in days.

It's probably impossible because the kernel only knows about faults, but you 
could give frequently but not recently used pages (your day-old browser 
window) priority over recently but not frequently used pages (your one-time 
grep).  You'd also need a way to allow cache to grow, which this would 
otherwise curtail.

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

Alchemists became chemists when they stopped keeping secrets.
