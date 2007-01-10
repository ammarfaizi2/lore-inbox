Return-Path: <linux-kernel-owner+w=401wt.eu-S932700AbXAJDlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbXAJDlK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 22:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbXAJDlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 22:41:09 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39305 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932700AbXAJDlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 22:41:08 -0500
Date: Tue, 9 Jan 2007 19:41:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] allow setting vm_dirty below 1% for large memory
 machines
Message-Id: <20070109194101.c8a1beaa.akpm@osdl.org>
In-Reply-To: <17828.23967.419596.669927@notabene.brown>
References: <17827.22798.625018.673326@notabene.brown>
	<20070109021017.447b682d.akpm@osdl.org>
	<17828.23967.419596.669927@notabene.brown>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007 14:29:35 +1100
Neil Brown <neilb@suse.de> wrote:

> > 
> > It would be better if we can avoid creating the second global variable.  Is
> > it not possible to remove dirty_ratio?  Make everything work off
> > vm_dirty_kb and do arithmetricks at the /proc/sys/vm/dirty_ratio interface?
> 
> Uhmmm... not sure what you are thinking.
> I guess we could teach vm.dirty_ratio to take a floating point number
> (but does sysctl understand that?) so we could set it to 0.01 or
> similar, but that is missing the point in a way.  We don't really want
> to set a small ratio.  We want to set a small maximum number.

I mean remove the kernel-internal dirty_ratio variable and use
/proc/sys/vm/dirty_ratio as an accessor to `long vm_dirty_kb', with
appropriate conversions when /proc/sys/vm/dirty_ratio is written to and
read from.

> It could make lots of sense to have two numbers.  A ratio that wins on
> a small memory machine and a fixed number that wins on a large memory
> machine.  Different trade offs are more significant in the different
> cases.

hm.

> > 
> > We should perform the same conversion to dirty_background_ratio, I suspect.
> > 
> 
> I didn't add a fixed limit for dirty_background_ratio as it seemed
> reasonable to assume that (dirty_background_ratio / dirty_ratio) was a
> meaningful value, and just multiplied the final 'dirty' figure by this
> ration to get the 'background' figure.

Sounds complex.  Better, I think, to create (and recommend) vm_dirty_kb and
vm_dirty_background_kb and deprecate the old knobs.

> > And these guys should be `long', not `int'.  Otherwise things will go
> > pearshaped at 2 tabbybytes.
> 
> I don't think so.  You would need to have blindingly fast storage
> before there would be any interest in vm_dirty_kb getting anything
> close to t*bytes.  But I guess we can make it 'unsigned long' if it
> helps.
> 

A 16TB machine would overflow that int by default.
