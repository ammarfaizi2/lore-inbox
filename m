Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbTLCSHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 13:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTLCSHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 13:07:13 -0500
Received: from bolt.sonic.net ([208.201.242.18]:28352 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S264136AbTLCSHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 13:07:11 -0500
Date: Wed, 3 Dec 2003 10:07:09 -0800
From: David Hinds <dhinds@sonic.net>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031203100709.B6625@sonic.net>
References: <20031203143122.GA6470@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031203143122.GA6470@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 03:31:22PM +0100, Jörn Engel wrote:
> Really bad code demand really rude words, sorry.
> 
> 
> After playing with stack checking again, I've found this little beauty
> in 2.6.0-test3: [1]
> 
> WARNING: recursion detected:
>       20  read_cis_cache
>       36  pcmcia_get_tuple_data
>      308  read_tuple
>      448  pcmcia_validate_cis
>       12  readable
>       24  cis_readable
>       28  do_mem_probe
>       24  inv_probe
>       16  validate_mem
>       32  set_cis_map
>       28  read_cis_mem
>      284  verify_cis_cache
> 
> Explanation:
> verify_cis_cache calls read_cis_mem, which calls set_cis_map, which
> call ..., which calls read_cis_cache, which finally calls
> verify_cis_cache again.

Err... no it doesn't.  verify_cis_cache() is called from exactly one
place which is not in the list of functions here.  I do not understand
how this recursion checking is being done but there's something weird
going on.  set_cis_map() does not call any function on this list.  I
think set_cis_map() should be setup_cis_mem().

> Most likely this recursion will never occur, as one of those calls can
> depends on circumstances that prohibit recursion, but semantic
> checking is a bitch for software and in this case even for humans.
> Put another way: THERE IS NO WAY TO MAKE SURE THIS WORKS.

Isn't that a bit strong a statement?

The semantics of the code goes like this.  read_cis_mem() checks to
see if something has been done.  If it hasn't been done, it leads to
validate_mem() which first does that thing, and then does some stuff
that leads to read_cis_mem() being called again.  When read_cis_mem()
is reentered, it is guaranteed that the condition for recursion does
not exist.

Is that so complex as to be incomprehensible by a mere human?  To
remove the apparent recursion seems to me to require duplicating a
fairly long code path, which is why I did it this way in the first
place.  The stack usage of this code path is definitely something that
should be (and can be easily) fixed.

-- Dave
