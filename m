Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVCHQ6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVCHQ6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 11:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVCHQ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 11:58:31 -0500
Received: from sta.galis.org ([66.250.170.210]:53896 "HELO sta.galis.org")
	by vger.kernel.org with SMTP id S261224AbVCHQ6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 11:58:16 -0500
From: "George Georgalis" <george@galis.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
  users@spamassassin.apache.org,
  misc@list.smarden.org,
  supervision@list.skarnet.org,
  nix@esperi.org.uk,
  mkettler@evi-inc.com
Date: Tue, 8 Mar 2005 11:58:14 -0500
To: Nix <nix@esperi.org.uk>, Matt Kettler <mkettler@evi-inc.com>
Cc: linux-kernel@vger.kernel.org, users@spamassassin.apache.org,
       misc@list.smarden.org, supervision@list.skarnet.org
Subject: Re: a problem with linux 2.6.11 and sa
Message-ID: <20050308165814.GA1936@ixeon.local>
References: <20050303214023.GD1251@ixeon.local> <6.2.1.2.0.20050303165334.038f32a0@192.168.50.2> <20050303224616.GA1428@ixeon.local> <871xaqb6o0.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xaqb6o0.fsf@amaterasu.srvr.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 01:37:03PM +0000, Nix wrote:
>On Thu, 3 Mar 2005, George Georgalis uttered the following:
>> I recall a problem a while back with a pipe from
>> /proc/kmsg that was sent by root to a program with a
>> user uid. The fix was to run the logging program as
>> root. Has that protected pipe method been extended
>> since 2.6.8.1?
>
>The entire implementation of pipes has been radically revised between
>2.6.10 and 2.6.11: see, e.g., <http://lwn.net/Articles/118750/> and
><http://lwn.net/Articles/119682/>.
>
>Bugs have been spotted in this area in 2.6.10: this may be
>another one.

Thanks, my issue is clearly between 2.6.10 and 2.6.11; though I won't be
able to drill down anything more specific, for a while. The links
do look relevant but I cannot say for sure.

Here's what I'm doing that is broken. I use tcpserver (functionally
similar to inetd) to receive an incoming smtp connection. While the
smtp session is still open, the message is piped to a temp file which
is then scanned for spam, if it passes the temp file is piped to my
local delivery program. If it doesn't pass the spam test or the delivery
program fails (disk full etc), the respective error code, if any,
is passed to tcpserver. The corresponding accepted, temporary reject or
permanently reject signal is passed to the remote sender.

The temp file is then removed or, for spam, it is cataloged for
statistics and/or abuse reporting. An additional copy is kept in a
traditional maildir to check for false positives.

#!/bin/bash
# exit 31 = permanently refuse
# exit 71 = temporarily refuse
# pwd is /var/qmail
echo $0 # for the logs
scq="spamc-queue" # a maildir with qmaild write perms
tmp="${scq}/`safecat "${scq}/tmp" "${scq}" </dev/stdin`" \
	|| { echo "Error $?"; exit 71; } # put the pipeline to disk, if possible
	# ${scq}/tmp is a temp for this function ${scq} is temp for this program
score=`spamc -x -c <"$tmp"` # score it with spamd
sce=$?
echo $score # for the logs
case $sce in
0) # ham
	host=`cat control/me`
	formail -f -A "X-spamc: ${score} by ${host}; `date -R`" \
		-A "X-tcpremoteip: $TCPREMOTEIP" <"$tmp" \
		| bin/qmail-queue # mark it and pass to the regular queue
	qqe=$?
	rm "$tmp"
	exit $qqe # return whatever qmail-queue exits as
;;
1) # spam 
	sipd="$scq/IP/`echo $TCPREMOTEIP | sed 's|\.|/|g'`"
	mkdir -p $sipd/{new,cur,tmp} # make a spam ip maildir, if needed
	printf "$TCPREMOTEIP\t`date`\n" >>$sipd/date # keep track of when they came
	maildir "${sipd}" >/dev/null <"$tmp" # keep a copy for reporting
	maildir "${scq}"  >/dev/null <"$tmp" # save it to verify no falseys
	rm "$tmp"
	exit 31
;;
*) # spamc error, 
	echo "$0 error, spamc exit $sce"
	exit 71
esac
exit 81 # Internal bug



>If you can reproduce it consistently, *please* report
>this to the linux-kernel list!

I did, but have had no response to my followup:

Date: Fri, 4 Mar 2005 15:58:43 -0500
Subject: Re: problem with linux 2.6.11 and sa


>(I don't see what you mean by `a pipe rom /proc/kmsg', though:
>pipes connect processes, not files. File redirections are
>quite different and should work unchanged in 2.6.11.)


An interesting technique that allows a program (such as a log writer)
to run as an unprivileged user, while receiving privileged data. (taken
almost verbatim from Gerrit Pape's socklog)

#!/bin/sh
exec </proc/kmsg
exec 2>&1
exec softlimit -m 2000000 setuidgid nobody socklog ucspi

This script, run by root takes its stdin from /proc/kmsg then combines
its stdout and stderr, and exec-switches to the socklog program run
as an ucspi application listening to the domain stream socket, as
nobody:nogroup, with memory consumption limited to 2Mb. (and sends
log to stdout)

It worked flawlessly until several kernel revs back when the kernel
started protecting kmsg and wouldn't allow the user program to receive
it, result: nothing sent to the logging program and no error. The fix
was to run socklog as root instead of nobody.

// George



-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
