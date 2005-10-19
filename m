Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVJSUtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVJSUtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVJSUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:49:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751327AbVJSUtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:49:21 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17238.45372.628520.739194@segfault.boston.redhat.com>
Date: Wed, 19 Oct 2005 16:49:00 -0400
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <Pine.LNX.4.63.0510152006340.30122@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
	<17203.7543.949262.883138@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
	<17205.48192.180623.885538@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
	<17208.24786.729632.221157@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510152006340.30122@donald.themaw.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:

raven> On Mon, 26 Sep 2005, Jeff Moyer wrote:
>> ==> Regarding Re: autofs4 looks up wrong path element when ghosting is
>> enabled; Ian Kent <raven@themaw.net> adds:
>> 
raven> On Sat, 24 Sep 2005, Jeff Moyer wrote:
>> >> >> >> >> >> Ian, I'm not really sure how we can address this issue >>
>> without VFS >> >> changes.  Any ideas?
>> >> >> >> 
>> >> >> 
raven> I'm aware of this problem.  I'm not sure how to deal with it yet.
raven> The case above is probably not that difficult to solve but if the
raven> last component is a directory it's hard to work out it's a problem.
>> >> >> Ugh.  If you're thinking what I think you're thinking, that's an
>> ugly >> >> hack.
>> >> 
raven> Don't think so.
>> >>
raven> I've been seeing this for a while. I wasn't quite sure of the source
raven> but, for some reason your report has cleared that up.
>> >>
raven> The problem is not so much the success returned on the failed mount
raven> (revalidate). It's the return from the following lookup. This is a
raven> lookup in a non-root directory. I replaced the non-root lookup with
raven> the root lookup a while ago and I think this is an unexpected side
raven> affect of that. Becuase of other changes that lead to that decision
raven> I think that it should be now be OK to put back the null function
raven> (always return a negative dentry) that was there before I started
raven> working on the browable maps feature.
>> >>

raven> I've had a look at this a bit more deeply.

raven> As we know we can't make the path walk lookup fail by
raven> autofs4_revalidate simply returning 0 and to change that in the
raven> kernel would be far to dangerous. So we need to deal with this
raven> during the following lookup. This just means we get an unwanted
raven> callback to the daemon which will fail and should not cause a
raven> problem.

raven> I'm still not fully clear on the reasoning behind the logic in
raven> try_to_fill_dentry when called with a negative dentry. One of the
raven> things it attempts to do is cache a lookup failure (ENOENT return
raven> from the wait). Unfortuneatly the subsequent test in
raven> autofs4_revalidate is a tautology, always returning true. So
raven> d_invalidate is never called to cleanup what might be a stale
raven> dentry. While this is not causing the problem stale dentrys are the
raven> problem.

raven> I still haven't decided whether it would be a good idea to return 0
raven> instead of 1 from try_to_fill_dentry for these failed mount
raven> attempts. All this would do is give the kernel more chances to clean
raven> up the stale dentries. The dentry in question won't be released at
raven> this point as it has a non zero reference count (I believe). But
raven> sooner or later they will go anyway when d_invalidate is called.

raven> So to resolve this we need to ignore negative and unhashed dentries
raven> when checking if directory dentry is empty.

raven> Please test this patch and let me know how you go.

OK, I've finally got 'round to testing your patch.  It does fix the test
case I was using.  My only concern is the potential for regressions.  I'll
try making sure all of my various maps still work as advertised.

Thanks!

Jeff
