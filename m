Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbUCJQEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbUCJQEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:04:22 -0500
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:4996 "EHLO
	rtp-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262675AbUCJQEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:04:20 -0500
To: Jouni Malinen <jkmaline@cc.hut.fi>
Cc: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
References: <yquj7jxuudvn.fsf@chaapala-lnx2.cisco.com>
	<Xine.LNX.4.44.0403091532020.27586-100000@thoron.boston.redhat.com>
	<20040310034014.GA3739@jm.kir.nu>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Wed, 10 Mar 2004 10:04:15 -0600
In-Reply-To: <20040310034014.GA3739@jm.kir.nu> (Jouni Malinen's message of
 "Tue, 9 Mar 2004 19:40:14 -0800")
Message-ID: <yqujbrn4wuww.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Jouni Malinen outgrape:
>> On Tue, 9 Mar 2004, Clay Haapala wrote:
>> > I had the same thought in my attempt at adding CRC32C to the
>> > crypto routines, that what was needed was "digests + setkey".
>> > But I didn't want to add the key baggage to digests, and so
>> > created a new alg type (CHKSUM), with pretty much identical code
>> > to digest, but with a modified init and a new setkey interface.
> 
> On Tue, Mar 09, 2004 at 03:32:58PM -0500, James Morris wrote:
>> I think that adding a setkey method for digests is the simplest
>> approach.
> 
> 
> I took a quick look at the CRC32C patch and it looked like the only
> needed change for the digest type was the new handler for setting a
> 32-bit seed. I used setkey handler that takes an arbitrary key data
> and length (Michael MIC uses 64-bit key/seed). As far as I could
> tell, this setkey function should be enough for CRC32C needs,
> too. Clay, please let me know if I missed something here. James,
> please consider merging this into Linux 2.6 tree if there are no
> issues with CRC32C.
> 

I believe that is all that CRC32C requires.  I had hesitated to add
the setkey/setseed method because I mentally had it tied to "init",
which is not necessary, as your patch shows.  I also didn't know what
to do with the "&flags" parameter, but I gather that passing it in and
not using it is fine.  Should "unsigned int keylen" be also "const" or
does that matter?

>  
> +static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned
> +int keylen) { u32 flags; if (tfm->__crt_alg->cra_digest.dia_setkey
> +== NULL) return -1; return
> +tfm->__crt_alg->cra_digest.dia_setkey(crypto_tfm_ctx(tfm), key,
> +keylen, &flags);
> +}
> +

-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
  Windows XP 'Reloaded'?  *Reloaded?*  Have they no sense of irony?
