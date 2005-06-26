Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVFZDQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVFZDQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 23:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVFZDQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 23:16:28 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:9226 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261498AbVFZDOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 23:14:36 -0400
Message-ID: <42BE1D9A.80006@slaphack.com>
Date: Sat, 25 Jun 2005 22:14:34 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>            <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
In-Reply-To: <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Sat, 25 Jun 2005 13:33:27 CDT, David Masover said:
> 
>>>Now *think* for a moment - how does a hypothetical Reiser4 using ext3 format
>>>gain any speed advantage with small files, when the speed advantage is based
>>>on using a format other than ext3?
> 
> 
>>happen in RAM.  If you do a ton of work with a dataset that stays in
>>RAM, Reiser probably performs as well or better than a ramdisk, because
>>changes that get overwritten while still in RAM never actually touch the
>>disk.
> 
> 
> At that point, since the actual buffer management is being done at the VFS
> level (see fs/buffer.c and friends) what you're really comparing is the speed
> of journalling metadata - at which point you need to be *very* careful to

No, just metadata.

> specify exactly what configuration you're talking about.  If you don't believe
> me, investigate why mounting a filesystem with 'noatime,nodiratime' can make a
> dramatic difference totally independent of the underlying filesystem, but the
> actual amount of gain is dependent on format (hint - how far do the heads have
> to move to record 3 atime updates against 3 random inodes on an ext2, an ext3,
> and a VFAT filesystem, assuming no other disk activity), and why
> ext3 has 3 different modes data=ordered/writeback/journal.

I'm not saying format doesn't matter for _all_ optimizations, but there
are some common ones for which it does matter.

>>       Reiser also doesn't fragment as quickly as ext3, and I don't
>>think that has anything to do with its format.
> 
> 
> Care to explain why it's not format-dependent? 

Reiser4 and XFS both do lazy allocation.  They both avoid allocating
blocks until they run out of buffer RAM.  When they have to, they
allocate and flush everything.

This may have changed a bit -- Hans was talking about a more stack-like
system, to avoid the system locking up for tens of seconds at a time
while ALL ram is flushed -- but the principle is the same.

That principle is that if you have a large chunk of data to allocate all
at once, you are more likely to know how it should be arranged on disk.
 If you allocate every write(2) or every 5 seconds, how do you know if
they are writing 2K or 2 gigs?  You might try to pack it into 1 meg of
space, then 5 megs, and so on, but you end up with quite a fragmented file.

With allocate-on-flush, if you've got more like 100 megs to allocate at
once, you can find space for that 100 megs.  In fact, with the Reiser
format, you can pack lots of tiny (much less than a block) files
together to save space and speed things up.

But the lack of fragmentation is not format-dependent.

>>The FS that gets merged ahead of time without plugins would no longer be
>>Reiser4.  Go read the whitepaper, or tell me why I'm wrong, but even
>>symlinks are implemented as plugins.
> 
> 
> Which is another way of saying Reiser4 can't be merged in its present form.

Actually, I'll have to go back on this a bit.  There are different kinds
of plugins, and I'm not sure exactly which people want in the VFS.  This
may be because nobody's said that, though.

Still, while plugins may not depend on Reiser, Reiser depends on plugins.

>>Actually, plugins are just as easy or easier than crypto-loop or
>>dm-crypt.  And why shouldn't my crypto be easy?  Most users are insecure
>>in all kinds of ways because of that attitude -- security is HARD, so I
> 
> There's a vast distinction between "easy for implementors" and "easy for
> users".  Jaari Russo's loop-aes stuff does a wonderful job of being "easy for
> users" - just say "mount", answer the passphrase, and you're good to go.  The

Not as easy as a plugin, though.  Per-file granularity is nice.
Especially on a USB key, where you're changing the files all the time.
Sometimes you want just a few (encrypted) SSH/GPG keys and a bunch of
(unencrypted) mpegs, and sometimes you want just a few (unencrypted)
HTML files and a bunch of (encrypted) top-secret blueprints in extremely
high-res JPEG/PNG format.

A loop file on a keychain is only slightly better than partitions.

[...]
> Meanwhile, PGP was designed to be used in an environment where you could do
> this:  "Today's secret plans are AES256 encrypted.  The key is the next key in
> your one-time-pad book, XOR'ed with your 128-bit secret key - do it in your head".
> (And yes, you can easily memorize a 16-digit hex number and learn to do an XOR
> with another 16-digit number, if failing to do so means you could end up dead).
> 
> This is inconvenient for the user, but intractable for an attacker to create a
> scenario where they can just 'vi /each/decrypted/file' ;)

Just as intractable the plugin way.  Not to mention, setting up a
ramdisk properly and decrypting to said ramdisk is a step you might
forget, which might put your files on the disk unencrypted.  Much more
unforgivable than the heinous crime of making top-secret government work
easier!

>>won't do it.  If security is transparent, just enter a password and go,
>>then more people would do it.
> 
> 
> "Just enter a password and go, then more people would do it".
> 
> Two words: "phishing e-mail".

If someone's going to learn about crypto, they are going to learn about
how to avoid phishing scams.  Both can be easy.

After all, private/public keys can be made user-friendly and secure.  At
the same time!

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr4dmngHNmZLgCUhAQLJVA//WE20P/91cVuDclUT0W6bOX8bJvycOilB
v55mUI9eoTdWink80RNo8QZ4aM1sidOrbtKglNmWdku1Fr80JW8HEPeQWRWR8PUL
midO7ulTfRldBdM0mU+Ojl+Dj8vln6Qr+80Rveo5XDUlcWVwKHH7d87ONlFRlwIO
NZMQXbB90huexJVoiITIGkFcDeoSdth/Em3cKjGhoEpreGkw6DuQzvS3aTOV+Fw4
c8neGsw2Tnx05+LuwE1VKxL7aV6U/Z0JDXwMqJtvINvkxnu6mKR++hRkWKW374LY
71idZzBu92oTNlEl02+y/EUGGU7+TMtduTo98ww4eN9r8bpB/WbMuOm+w05EKHKg
H1OT1CX+G4sP/0GZaslPzh8z7cGI6318FN3Twk922J8t3dWcmNer4ULt6rp+c/38
stjbammdaBTWNTYg/BjZ+oedhMa4BHVTzwU2R0HpEzI3EIj/5rjek/D1cWzuBu/C
NQ4QfVKJPHLgjKK4DV3iLQTkNpXC2skcluJ4FC1c+VYZTx8wvIrVUmJfPJajLAVg
en42jbCYzdldtzR/yYal3b7KCeJoi1x1PUvStgL6iWSe7MjEJoF4jV/TcmE2gLf3
RzQUQ0UuMMisdQ2qbKAA3BrbZV239P/HUtyZdnIj8yWX4hF5Hhu7G1Ncz545VCdk
+e0D/XVpgbc=
=EBr/
-----END PGP SIGNATURE-----
