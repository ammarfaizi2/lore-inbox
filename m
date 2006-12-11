Return-Path: <linux-kernel-owner+w=401wt.eu-S1762646AbWLKINR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762646AbWLKINR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 03:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762648AbWLKINR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 03:13:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:1909 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762646AbWLKINQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 03:13:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fIdgX6B2tSQe3Ey7hL525fxUNmLFnrmabQlD3FiD9f71cJlS+lzg89el0ifDSam7xLU1yu/QVFw72ARq+3PhdhSpOZqbSacCX6QCh/HdNcPmARvnlabS4Bld+ZitBnKDLOqjOaZE8eUXux3uzyTWTIjbGVZ6teRtLznSNYdt3xM=
Message-ID: <787b0d920612110013w755996f8xf9bea48e900e304@mail.gmail.com>
Date: Mon, 11 Dec 2006 03:13:15 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dsingleton@mvista.com, jgreen@mvista.com
Subject: Re: new procfs memory analysis feature
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Singleton writes:

> Add variation of /proc/PID/smaps called /proc/PID/pagemaps.
> Shows reference counts for individual pages instead of aggregate totals.
> Allows more detailed memory usage information for memory analysis tools.
> An example of the output shows the shared text VMA for ld.so and
> the share depths of the pages in the VMA.
>
> a7f4b000-a7f65000 r-xp 00000000 00:0d 19185826   /lib/ld-2.5.90.so
>  11 11 11 11 11 11 11 11 11 13 13 13 13 13 13 13 8 8 8 13 13 13 13 13 13 13

Arrrgh! Not another ghastly maps file!

The original was mildly defective. Somebody thought " (deleted)" was
a reserved filename extension. Somebody thought "/SYSV*" was also
some kind of reserved namespace. Nobody ever thought to bother with
a properly specified grammar; it's more fun to blame application
developers for guessing as best they can. The use of %08lx is quite
a wart too, looking ridiculous on 64-bit systems.

Now we have /proc/*/smaps, which should make decent programmers cry.
Really now, WTF? It has compact non-obvious parts, which would be a
nice choice for performance if not for being MIXED with wordy bloated
parts of a completely different nature. Parsing is terribly painful.

Supposedly there is a NUMA version too.

Along the way, nobody bothered to add support for describing the
page size (IMHO your format ***severely*** needs this) or for the
various VMA flags to indicate if memory is locked, randomized, etc.

There can be a million pages in a mapping for a 32-bit process.
If my guess (since you too failed to document your format) is right,
you propose to have one decimal value per page. In other words,
the lines of this file can be megabytes long without even getting
to the issue of 64-bit hardware. This is no text file!

How about a proper system call? Enough is enough already. Take a
look at the mincore system call. Imagine it taking a PID. The 7
available bits probably won't do, so expand that a bit. Just take
the user-allowed parts of the VMA and/or PTE (both varients are
good to have) and put them in a struct. There may be some value
in having both low-privilage and high-privilege versions of this.

BTW, you might wish to ensure that Wine can implement VirtualQueryEx
perfectly based on this.
