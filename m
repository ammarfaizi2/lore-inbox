Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVF0HQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVF0HQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVF0HNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:13:05 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:9995 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261901AbVF0HH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:07:56 -0400
Message-ID: <42BFA5C2.1010807@slaphack.com>
Date: Mon, 27 Jun 2005 02:07:46 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Hubert Chan <hubert@uhoreg.ca>, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <87y88webpo.fsf@evinrude.uhoreg.ca> <200506270459.j5R4xdZp005659@turing-police.cc.vt.edu>            <42BF9489.9080202@slaphack.com> <200506270624.j5R6OWFn008836@turing-police.cc.vt.edu>
In-Reply-To: <200506270624.j5R6OWFn008836@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 27 Jun 2005 00:54:17 CDT, David Masover said:
> 
> 
>>There has been some mention of inheritance, but I've forgotten how
>>that's supposed to work.  If there's some sort of inheritance where
>>children inherit properties of their parent directory, and also inherit
>>changes to those properties, than Hans probably wants that to be the
>>prefered way of doing things?
> 
> 
> Well, the 'chmod g+s dirname/' example *is* just "children inherit the
> group of the directory", and somebody didn't like that.. ;)

Respectfully ignoring this until he can comment.  I suspect he made a
mistake, but I'm trying to avoid putting words in his mouth...

>>>Now throw in multiple users and CPU limits.  User A enters that directory and
>>>references everything, causing the buffer cache to get filled up.  While there,
>>>A makes changes, so the pages are dirty - "for i in */*; do echo " " >> $i; done"
>>>would do the job...  User B now does something that causes a writeback of one
>>>of those buffer cache pages.
>>>
>>>A) What process currently gets ticked for the CPU and I/O for the writeback?
>>>
>>>B) In your model, who will get ticked for the resources?
>>>
>>>C) Will the users riot? (Note that you can't win here - currently, the "price"
>>>of writing back A's and B's pages are about equal.  However, if A gets dinked
>>>for an expensive writeback due to B's process, A will get miffed.  If B gets
>>>charge for an expensive writeback of A's, B will get miffed. If you say "screw it"
>>>and bill it to a kernel thread, the bean counters will get miffed... ;)
>>
>>If I understand this correctly, this is somewhat like if user A creates
>>a 50 meg file on a system with 100 megs free RAM, and user B runs
>>"sync".  Also similar to if B were to suddenly fill up 75 megs of RAM,
>>forcing A's file to be flushed -- last I checked, in Reiser4, only a
>>sync or memory pressure causes writes to flush.
> 
> 
> Exactly the same sort of thing - traditionally it's been more or less ignored
> in the system accounting, because A would usually average out to causing as
> many I/Os as B did, and they were roughly equal in cost so it was a wash.

Even if A is doing A/V work and B is programming?

> However, if one user has a much higher per-page cost than the other, the
> imbalance can start to matter *very* quickly....

I see.  My instinct is to charge A if B just caused a sync, but change B
if B was automagically forcing A to do something...

But I still don't understand the layers involved well enough.

>>Right?  This is tempting to comment on, but I want to make sure I grok
>>it first...
> 
> 
> For more fun, consider how you can write 1 megabyte of data to a file,
> lseek to the beginning and start writing again - and you go over quota
> on the *second* write even though you're over-writing already existing
> data.  Can happen if you're compressing, and the second write doesn't
> compress as well as the first. (To be fair, we already have similar
> issues with sparse files - but at least 'tar --sparse' has an easy way
> to deal with it compared to this. ;)

To be even more fair, but possibly launch another flame, Reiser4
reserves 5% of disk space by default to avoid this kind of thing.  But
that's talking about total disk, not quotas.

Also doesn't answer my question, but it seems I'm starting to get it.

How do we get over quota errors, btw?  Can we get them from write()
calls?  If so, I don't see a Problem(TM), just an annoyance.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+lwngHNmZLgCUhAQKYUw/9HmIZRqL7+1qcji/y4EhgUMftbdaKHUaJ
D+gyssdIgkfNwAR5vEvE6Lb0Fdj4zWU12nnx/ppL0nU1n6pWOBqyOMMtbHs4dbwe
iTJmoe1OCBM5uOS8bSdYUfVFUWNRF5+MPc8cWcpBa1LPCBmpzUnr5hS8iuNknWl2
7r6Hs64GSJ1JI7djE0P8fZVTou95azc/1pRU4kRtlsavXMmmAL3sefA9HS4b85VB
haOuNPmDIhJhPXhAMY6ZYKq3xnVyGWuiU6Z1Clv8JyP0Y7jaqGjF+V16zVSKvJH8
d0BrN05zGL1CIYDQrLtC0CQHuuLek34NDYimgVSLhkSB73GJ/MHxfO++68Pnhxhz
NOF86tPhoDQHhdEkUw0Kq5ZeI43ETejbMRIMoPAhuWo1vCQNFsfsSLljWLatBGNr
Lzgb0Q74Iqnrw9fPwrQttA/aPdlnVmOGv1qVYz/LQ8C+UHPVLXkjm5NVzHFDesPS
XXRZxSxPcOcMK9zPxLNer3zPlGPNOjQbylfL6+RwcJDmHq3IrDJDLY4TB4cZzJpc
gJyXrpSjprYCbSi+cc1d1R4cLcbdMHjR/rEszibLyeMuINYyx6vJklKy9xvpmyEB
woGrADFDnmKyv4WOzswSgIM6s8U2dLY4GFM/GW7KLx+rMF98UDhGyLjvSyvIpigs
BJz4T03qCtA=
=GoJz
-----END PGP SIGNATURE-----
