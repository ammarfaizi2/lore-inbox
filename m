Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVARSxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVARSxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVARSxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:53:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:26109 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261387AbVARSwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:52:41 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16877.25993.329027.575972@tut.ibm.com>
Date: Tue, 18 Jan 2005 13:37:45 -0600
To: karim@opersys.com
Cc: Tom Zanussi <zanussi@us.ibm.com>, Aaron Cohen <remleduff@gmail.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41ED3C12.8030607@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	<41E899AC.3070705@opersys.com>
	<Pine.LNX.4.61.0501160245180.30794@scrub.home>
	<41EA0307.6020807@opersys.com>
	<Pine.LNX.4.61.0501161648310.30794@scrub.home>
	<41EADA11.70403@opersys.com>
	<Pine.LNX.4.61.0501171403490.30794@scrub.home>
	<41EC2DCA.50904@opersys.com>
	<Pine.LNX.4.61.0501172323310.30794@scrub.home>
	<41EC8AA2.1030000@opersys.com>
	<727e501505011720303ba4f2cd@mail.gmail.com>
	<41EC94BF.2080105@opersys.com>
	<16876.50139.587691.939056@tut.ibm.com>
	<41ED3C12.8030607@opersys.com>
X-Mailer: VM 7.18 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour writes:
 > 
 > Tom Zanussi wrote:
 > > I have to disagree.  Awhile back, if you remember, I posted a patch to
 > > the LTT daemon that would monitor the trace stream in real time, and
 > > process it using an embedded Perl interpreter, no less:
 > > 
 > > http://marc.theaimsgroup.com/?l=linux-kernel&m=109405724500237&w=2
 > > 
 > > It didn't seem to have any problems keeping up with the trace stream
 > > even though it was monitoring all LTT event types (and a couple of
 > > others - custom events injected using kprobes) and not doing any
 > > filtering in the kernel, through kernel compiles, normal X traffic,
 > > etc.  I don't know what volume of event traffic would cause this model
 > > to break down, but I think it shows that at least some level of
 > > non-trivial live processing is possible...
 > 
 > Good Point.
 > 
 > My bad. Thanks for bringing this up. Obviously this didn't get as
 > much attention as it should've had the last time it was posted,
 > especially as it allows very easy scripting of filtering in userspace.
 > That email you refer to is pretty loaded and I'm sure those who
 > are interested will dig through it. But in the interest of helping
 > everyone get a rapid understanding of what it does and how it does it,
 > can you break it down in to a short description, possibly with a
 > diagram? I'm sure many will find this very interesting.

It's so simple it doesn't really deserve a diagram, which I'm pretty
bad at anyway...

Basically all it does is loop around the received buffer, reading each
event and sending it off to a handler.  In this case the handler
massages the data into a form that allows it to be passed to the Perl
interpreter as arguments to a Perl function that in turn acts as
callback handler in the Perl interpreter.

At that point, the Perl callback can do whatever it wants with the
data - save events matching a certain pid and discard everything else,
keep running counts or time totals e.g. total syscall counts for each
pid, function call tracing (if you dynamically instrumented function
call entry/exit with kprobes for example), etc, etc, etc.  Probably
even more useful is the ability to monitor the event stream looking
for sporadically occuring events, again under the control of the Perl
interpreter, so your criteria for deciding what an 'important event'
is can be arbitrarily complex and incorporate past history.  It also
means that you don't have to save anything at all to disk until you
detect your specified condition (which makes tracing for days or weeks
on end more practical), at which point you can dump out the currently
mapped buffer containing the last bufsize number of events most likely
to be of interest anyway.

Perl makes this kind of quick and dirty processing extremely easy and
it has a lot of powerful language features such as nested hashes built
in, which is why I chose it, but you could of course avoid the extra
layer and the interpreter and do your filtering in straight C, or
create a binding for any language you want.

IMHO being able to do most of the filtering in user space like this
opens up a lot of avenues for not only one-off problem determination
hacks, but a proliferation of more substantial tools, considering how
easy it is to put together applications using for instance the copious
number of Perl modules available.

Tom

 > 
 > Thanks,
 > 
 > Karim
 > -- 
 > Author, Speaker, Developer, Consultant
 > Pushing Embedded and Real-Time Linux Systems Beyond the Limits
 > http://www.opersys.com || karim@opersys.com || 1-866-677-4546

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

