Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUAOWj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUAOWj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:39:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39849 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263062AbUAOWjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:39:12 -0500
Subject: Re: filesystem bug?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Tsuchiya Yoshihiro <xxtsuchiyaxx@ybb.ne.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, tschiya@labs.fujitsu.com,
       dlion2004@sina.com.cn, Stephen Tweedie <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <0586254E-46DA-11D8-B45E-00039341E01A@ybb.ne.jp>
References: <E4E4EAA7-3879-11D8-8822-00039341E01A@ybb.ne.jp>
	 <Pine.LNX.4.58L.0312301556380.23875@logos.cnet>
	 <74964CA8-3B50-11D8-B879-00039341E01A@ybb.ne.jp>
	 <1074109164.4538.8.camel@sisko.scot.redhat.com>
	 <0586254E-46DA-11D8-B45E-00039341E01A@ybb.ne.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1074206327.4811.519.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jan 2004 22:38:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-01-14 at 21:38, Tsuchiya Yoshihiro wrote:

> I usually use two to seven boxes at a time, and I get about two problems
> out of them within about two nights.

I was able to reproduce with your script, too: even on ramfs.  Curiouser
and curiouser.

Al Viro was a help getting further, and we nailed the reason for the
failure.  I got a failure:

"something wrong (diff) happened at ae:619-th trial"

corresponding to the script code:

                mkdir $TARGETDIR/dirXC$i || echo "Error $? making $TARGETDIR/dirXC$i" > $RDIR/MD-ERR-$1 2>&1
                cd $TARGETDIR/dirXC$i > $RDIR/CD-ERR-$1 2>&1

                if [ -s $RDIR/CD-ERR-$1 ]
                then
                        echo "something wrong (cd) happened at $1:$i-th trial "
                        (df .; df -i .) > $RDIR/DF-$1
                        exit;
                fi

                tar zxf $MOZSRC >> $ERRORF

#                echo "test dir for $TARGETDIR" >> $INOFILE-$1
                ls -lid $SOURCE >> $INOFILE-$1

                diff -rq $TARGETDIR/$SOURCE $TARGETDIR/dirXC$i/$SOURCE > $RESULTS/dirXC$i.result 2>&1
                DIFFSIZE=`ls -l $RESULTS/dirXC$i.result | awk '{print $5}'`
                if [ $DIFFSIZE != 0 ];
                then
                        echo "something wrong (diff) happened at $1:$i-th trial "
                        (df .; df -i .) > $RDIR/DF-$1
                        exit;

and psacct was able to trace the order in which stuff happened; lastcomm showed:

tee                     guest    ??         5.55 secs Thu Jan 15 22:15
tar                     guest    ??         0.08 secs Thu Jan 15 22:24
gzip                    guest    ??         0.25 secs Thu Jan 15 22:24
xc-1.2                  guest    ??         0.02 secs Thu Jan 15 22:15
xc-1.2             F    guest    ??         6.37 secs Thu Jan 15 22:15
xc-1.2             F    guest    ??         0.00 secs Thu Jan 15 22:24
df                      guest    ??         0.00 secs Thu Jan 15 22:24
df                      guest    ??         0.01 secs Thu Jan 15 22:24
xc-1.2             F    guest    ??         0.01 secs Thu Jan 15 22:24
awk                     guest    ??         0.00 secs Thu Jan 15 22:24
ls                      guest    ??         0.01 secs Thu Jan 15 22:24
diff                    guest    ??         0.01 secs Thu Jan 15 22:24
rm                      guest    ??         0.02 secs Thu Jan 15 22:24
ls                      guest    ??         0.00 secs Thu Jan 15 22:24
mkdir                   guest    ??         0.01 secs Thu Jan 15 22:24

Reading from the bottom up: we get the "mkdir" and "ls -lid" of the new
directory, but not the tar; then the "rm &" of the previous iteration
completes; then there's the diff that failed, and the ls and awk from
that; then the two "df"s, then we exit. 

And *then*, after all that, the tar/gunzip finishes.  Remember, lastcomm
records the exit of each task, not its start.

So the problem seems to be that the shell is continuing beyond the "tar
xzf" before that command has finished, which is why we see ENOENT on
"cd" to the dir or on the diff.

The trace above was on the last running thread of the test.  All other
threads had completed, so there was no interleaving of test runs in the
psacct records.

Now, I can't tell from this whether it's a bash bug or an exit/signal
bug, but it doesn't look like a filesystem problem for now.  I'm going
to try with a different shell to see if that helps.

Cheers,
 Stephen

