Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269078AbUJQIAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269078AbUJQIAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 04:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUJQIAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 04:00:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30683 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269078AbUJQIAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 04:00:13 -0400
To: jmoyer@redhat.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, akpm@osdl.org
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	<20041005112752.GA21094@logos.cnet>
	<16739.61314.102521.128577@segfault.boston.redhat.com>
	<20041006120158.GA8024@logos.cnet>
	<1097119895.4339.12.camel@orbit.scot.redhat.com>
	<20041007101213.GC10234@logos.cnet>
	<1097519553.2128.115.camel@sisko.scot.redhat.com>
	<16746.55283.192591.718383@segfault.boston.redhat.com>
	<1097531370.2128.356.camel@sisko.scot.redhat.com>
	<16749.15133.627859.786023@segfault.boston.redhat.com>
	<16751.61561.156429.120130@segfault.boston.redhat.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 17 Oct 2004 04:59:51 -0300
In-Reply-To: <16751.61561.156429.120130@segfault.boston.redhat.com>
Message-ID: <orzn2lpyfc.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15, 2004, Jeff Moyer <jmoyer@redhat.com> wrote:

jmoyer> Yes, that sounds like a fine idea.  Here is a patch which does
jmoyer> this.  Andrew, I know you only want bug fixes, but I'd like to get
jmoyer> this into your queue for post 2.6.9, if possible.

> I got the partial read case wrong in the last patch.  In fact, it looks
> like this code path would perform infinite retries before.  This should
> address that by returning upon the first partial read.  Attached is a new
> version of the patch.

Don't you have to adjust poll/select as well, to test whether read has
any data to return immediately?  Squid is broken with the latest
FCdevel kernel, and this patch is in it.

The reason Squid breaks is that poll (or is it select? I forget) says
there's data to be read from cache files (as well as from error
message files read during start up), but then read fails with -EAGAIN.
If I bring the error files into memory with cat
/etc/squid/errors/ERR*, then squid will successfully start up, and
then, in order for it to not eat all the available CPU polling data
files and attempting to read from them, I need to start a command line
this:

pid=`pidof '(squid)'
while :; do
  lsof -p $pid |
  sed -n 's,.*\(/var/spool/squid/.*/.*/.*\),\1,p' |
  xargs cat /dev/null > /dev/null;
  sleep 5
done

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
