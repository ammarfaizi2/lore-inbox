Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269570AbUINQtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269570AbUINQtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269517AbUINQoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:44:19 -0400
Received: from holomorphy.com ([207.189.100.168]:54164 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269470AbUINQh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:37:26 -0400
Date: Tue, 14 Sep 2004 09:37:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914163712.GT9106@holomorphy.com>
References: <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914160150.GB13978@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
>> No, in general races of the form "permissions were altered after I
>> checked them" can happen.

On Tue, Sep 14, 2004 at 06:01:50PM +0200, Roger Luethi wrote:
> Can you make an example? Some scenario where this would be important?

Not particularly. It largely means poorly-coded apps may report gibberish.


On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
>> Checking that system calls succeeded is a minimum requirement at all
>> times. Misinterpreting error returns is the app's fault.

On Tue, Sep 14, 2004 at 06:01:50PM +0200, Roger Luethi wrote:
> It's async. You can't rely on return values. They'd have to be in
> netlink messages.

That's fine. Do these error messages specify which field access(es)
caused the error?


On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
>> Irritating. That must mean you can't ask for specific fields.

On Tue, Sep 14, 2004 at 06:01:50PM +0200, Roger Luethi wrote:
> How so? For process fields, the request block is one u32 indicating the
> number of field IDs to follow, then a bunch of u32 containing field IDs.
> Any subset of field IDs, in any order of the tool's choosing.
> The kernel replies with one message per process, each message containing
> all the fields the tool requested, in the same order.

Then assuming the error messages indicate which field access(es) caused
the error(s), you're already done; userspace must merely retry the
request with the offending fields cast out. Otherwise, you're still
done: userspace can merely retry the field accesses one at a time
(though it's nicer to say which ones caused the errors).


On Tue, 14 Sep 2004 08:37:58 -0700, William Lee Irwin III wrote:
>> Well, "return this set of fields" means there's only one type of
>> request necessary, and userspace merely iterates through the subsets
>> obtained by striking out fields to which accesses caused errors until
>> either the set is empty or the call succeeds. One field at a time at
>> all times also means there's only one type of request necessary. So I

On Tue, Sep 14, 2004 at 06:01:50PM +0200, Roger Luethi wrote:
> One field at a time at all times is unnecessarily slow.

Yes, that was the "slower and stupider than thou" option. You've
already vectorized field access requests, of which I heartily approve.


-- wli
