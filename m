Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSHGXS0>; Wed, 7 Aug 2002 19:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSHGXS0>; Wed, 7 Aug 2002 19:18:26 -0400
Received: from ppp-217-133-222-186.dialup.tiscali.it ([217.133.222.186]:58002
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S315690AbSHGXSY>; Wed, 7 Aug 2002 19:18:24 -0400
Subject: Re: [patch] tls-2.5.30-A1
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.44.0208080050300.7410-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208080050300.7410-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-pOHaf857a+rQkv3iFWOG"
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Aug 2002 01:21:48 +0200
Message-Id: <1028762508.1992.309.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pOHaf857a+rQkv3iFWOG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> your patch looks good to me - as long as we want to keep those 2 TLS
> entries and nothing more. (which i believe we want.) If even more TLS
> entries are to be made possible then a cleaner TLS enumeration interface
> has to be used like Christoph mentioned - although i dont think we really
> want that, 3 or more entries would be a stretch i think.
I think that 2 are enough.
Flat 32-bit programs set ds=es=ss=__USER_DS and cs=__USER_CS so they
only have fs and gs left.
16-bit programs and other odd ones can use the LDT support.

As for the interface I would suggest replacing the current one with a
single interface for LDT and GDT modifications that would provide the
following parameters:

unsigned table
- LDT
- GDTAVAIL: GDT starting from first TLS
- GDTABS: GDT starting from 0
- AUTO: starts with the 2 TLS entries and proceeds with LDT

unsigned operation
- set: copy to kernel space (enlarge table if necessary). If root, don't
check validity for speed, otherwise check to ensure the user is not e.g.
putting call gates to CPL 0 code.
- set1: like set, but passes a single entry directly in the num and ptr
parameters
- get: copy from kernel space
- free: free memory and lower limits. If entry = 0 and num = ~0,
completely frees table.
- map: only for LDT and for root, allows to directly point to a user
memory range 
- movekern: when support for per-task GDT is implemented, this would
allow to change the entries used for kernel entries. This would be
implemented with per-CPU IDTs and maybe dynamically generated code.
Useful for virtualization programs.

unsigned entry
- first entry affected. ~0 for first unused entry.

unsigned num
- number of entries affected

void* ptr
- pointer to read/write entries from

(table and operations may be merged)

Return value: first entry changed

e.g. libpthread would use table = AUTO, operation = set1, entry = ~0.

For the LDT things would be implemented as usual. For the GDT the
initial implementation would just modify TLS entries.
In future, support for dynamically allocated per-task GDTs could be
added.

I would implement this by adding ops to sys_modify_ldt.

BTW, tls_desc1/tls_desc2 would IMHO be better as gdt_desc[2].

I don't plan to implement this myself.


--=-pOHaf857a+rQkv3iFWOG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9UauMdjkty3ft5+cRAi2ZAKCB+BTIw3QSS8dlbff/AV7L1DkG4ACg3XyV
6YYTVvyOAahEhGrqmAy3+pg=
=JoAq
-----END PGP SIGNATURE-----

--=-pOHaf857a+rQkv3iFWOG--
