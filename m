Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWFMOev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWFMOev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWFMOev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:34:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34444 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751165AbWFMOeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 10:34:50 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: jdow <jdow@earthlink.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       nick@linicks.net, Bernd Petrovitsch <bernd@firmix.at>,
       marty fouts <mf.danger@gmail.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606131328.k5DDSRd4003689@laptop11.inf.utfsm.cl>
References: <200606131328.k5DDSRd4003689@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 15:34:16 +0100
Message-Id: <1150209257.2844.11.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 09:28 -0400, Horst von Brand wrote
> > >> Greylist those who have not subscribed.
> > > That is not easy to do.
> 
> > Somebody needs to write the code to make it easy to do for a list
> > server. It should not be hard to do.
> 
> Great! Show us how. I'd be delighted to use it here. 

For me, it would be three lines of extra code in my Exim configuration
and a cron job to extract the subscriber lists into a text file which
Exim can read -- and the latter is just because I haven't bothered to
check whether Exim could read the mailman database directly.

Once I ditch mailman and switch to something like exilist, Exim _will_
be able to get at those lists directly, so it'll be even simpler.

Given a config like my existing one at http://david.woodhou.se/eximconf/
all you have to do to trigger greylisting for a particular 'offence' is
to add to the $acl_m0 variable when your check for it is triggered.

Whenever that variable is non-empty, the mail is considered for
greylisting by the snippet of ACL code which I've put in its own file at
http://david.woodhou.se/eximconf/include/acl-greylist and which gets
called from the post-DATA ACL after the SpamAssassin stuff (which also
triggers greylisting, at low scores).

(Hm, I _really_ should pull my finger out and switch from my original
hackish implementation to the sqlite version which Jeff sent me --
acl-greylist-sqlite in the same directory.)

All I'd need would be a cron job which sticks a file for each list
somewhere, say /foo/bar/subscribers/, with the filename being the full
(user@domain) name of the list, and the file being just a plain text
list of addresses, one per line.

Then I'd add three lines to the Exim configuration, in the RCPT ACL:

warn recipients = dsearch;/foo/bar/subscribers
     !senders = lsearch;/foo/bar/subscribers/$local_part@$domain
     set acl_m0 = Post to $local_part list by non-subscriber.

Entirely untested... but certainly not particularly hard.

-- 
dwmw2

