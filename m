Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUCASkg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUCASkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:40:36 -0500
Received: from citi.umich.edu ([141.211.133.111]:29280 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261403AbUCASk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:40:28 -0500
Date: Mon, 1 Mar 2004 13:39:37 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-Reply-To: <Pine.LNX.4.44.0403011505150.5314-100000@dmt.cyclades>
Message-ID: <Pine.BSO.4.33.0403011328540.6255-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, Marcelo Tosatti wrote:

> On Mon, 1 Mar 2004, Chuck Lever wrote:
>
> > hi marcelo-
> >
> > your "fix" will break readahead again for NFS.  with the ">=" as you
> > propose, the read ahead code will never be able to read the last page of
> > the file as a coalesced read, it will always be a separate 4KB read.
> >
> > the problem is not the readahead code, it is the driver code that tries
> > to read beyond the end of the device.  my change merely exposed this
> > misbehavior.
> >
> > so there is a broken assumption somewhere about how the index of the last
> > page of a file/device is computed.  i think it is a problem when the file
> > ends exactly on a page boundary.
> >
> > alain, if you don't use the NFS client, marcelo's fix should work just
> > fine for you.  but i believe that in general it is incorrect.
>
> Okey, most drivers do no exhibit this problem indeed.
>
> We should try to fix the problematic drivers, then.

it may very well be that most drivers don't complain about reading past
the end of the device.

some have suggested that the end_index computation at the top of
generic_file_readahead is incorrect.  that is not beyond the pale, and i
can take a look at that.

this calculation:

        end_index = inode->i_size >> PAGE_CACHE_SHIFT;

i think the case where there are bytes in that last page work as i
intended.  the problem is that sometimes the end_index value points to a
page with zero bytes (for example when the file is exactly an integral
number of pages in length; this is always the case for most devices).

i_size = 4095   end_index = 0   total_pages_in_file = 1
i_size = 4096   end_index = 1   total_pages_in_file = 1
i_size = 4097   end_index = 1   total_pages_in_file = 2

so right at the boundary we have a little problem.

> If we can't do it easily and in a straightforward manner, I'm afraid we
> will have to undo your change because even if the "read end beyond of
> device" accesses are harmless (are they really harmless?), they must
> fixed.
>
> Agreed?

understood, and thanks for the giving me the opportunity to try to help
you fix it.

> I'll take a look at them later today, but I'm no expert, so help is very
> appreciated.
>
> We know that these have problems:
>
> - Promise ATA
> - ips (serveraid)

i don't have either of those.  can anyone who is willing to test a patch
on this hardware e-mail me so we can try this out?

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

