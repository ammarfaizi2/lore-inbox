Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTBQEQZ>; Sun, 16 Feb 2003 23:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTBQEQY>; Sun, 16 Feb 2003 23:16:24 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:1565 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S266810AbTBQEQW>;
	Sun, 16 Feb 2003 23:16:22 -0500
Message-ID: <3E506460.3010400@acm.org>
Date: Sun, 16 Feb 2003 22:26:08 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Corey Minyard <cminyard@mvista.com>,
       Werner Almesberger <wa@almesberger.net>,
       Zwane Mwaikambo <zwane@holomorphy.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org>	<3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org>	<3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net>	<3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net>	<3E4D3419.1070207@mvista.com>	<Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>	<20030214164436.H2092@almesberger.net> <3E4D4ADF.3070109@mvista.com>	<m17kc26pxs.fsf@frodo.biederman.org> <3E4FBAD0.4040808@acm.org> <m1y94f6gnp.fsf@frodo.biederman.org>
In-Reply-To: <m1y94f6gnp.fsf@frodo.biederman.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric W. Biederman wrote:

|Corey Minyard <minyard@acm.org> writes:
|
|  
|
|>Eric W. Biederman wrote:
|>
|>|Corey Minyard <cminyard@mvista.com> writes:
|>|
|>|>|
|>|>|(So adding a special mode to the power management code may
|>|>|be too much overhead. Besides, sometimes, you can just pull
|>|>|a reset line, and don't have to do anything even remotely
|>|>|related to power management.)
|>|>
|>|>True, I didn't mean the high-level power management code directly.  
But the
|>|>PCI API defines a suspend operation that could take a special mode 
for this.
|>|
|>|
|>|The generic device api has a shutdown method for this.  And in the 
non panic
|>|case we use it.  Not a lot of devices have it implemented but it exists.
|>|
|>|And except that it doesn't have a restriction that it can't block is 
pretty
|>|much what you want.
|>
|>That's a pretty big restriction.  Plus, you can't claim spinlocks.
|>
|>The panic shutdown is different from an orderly shutdown.  What the 
current
|>shutdown does is probably not what you want.
|>    
|>
|
|I do not see a large difference between the desired semantics of an
|orderly shutdown, and the desired semantics of a panic shutdown.
|
An orderly shutdown will:

~    * claim locks and block as necessary
~    * free memory associated with the device
~    * flush device queues
~    * Fully shut down the device

An orderly shutdown should make sure the system remains sane after it
finishes and the data on the device is correct.

A panic shutdown should only disable DMA with as little code as possible
without locking, blocking, etc.  No effort should be taken to keep the
system sane (beyond clobbering memory), since it's not sane to begin 
with :-).

You may want to say that this shutdown will be the panic shutdown and not be
an orderly shutdown.  That's fine, although I would suggest a name change.
I couldn't find any documentation on what the shutdown call was supposed 
to do.

|  
|
|
|Because the kernel to handle the panic only initializes those devices
|it can reliably initialize from any state.   And it is living in an
|area of memory the old kernel did not allow DMA to.
|
Are you sure this will be ok?  I'm not sure either way.  How much memory 
does
a kernel take to boot up and operate for this?  If it's a few meg, it's 
probably livable.
If it's a lot of memory, it's probably not going to be acceptable.

Plus, perhaps you would want to protect the output of the kernel dump 
somehow.
That's going to be a lot more memory than you can reserve.  And if you 
can shut
off DMA, none of this should matter anyway.

The rest of what you said, about the panic kernel only taking the core 
dump and
then rebooting, makes sense to me.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+UGRfIXnXXONXERcRArgvAJ96cqVaxZeA83KuR1kSXFKVRSnpIACfQ83W
gc5bibmlh4sPmmq6onPc5w0=
=bgpj
-----END PGP SIGNATURE-----


