Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbUKVVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbUKVVsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUKVVmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:42:37 -0500
Received: from mail.tmr.com ([216.238.38.203]:52238 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262331AbUKVVcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:32:11 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Strange ssh hang with kernel 2.6.9
Date: Mon, 22 Nov 2004 16:31:49 -0500
Organization: TMR Associates, Inc
Message-ID: <41A25AC5.7040402@tmr.com>
References: <200411221007.47237.garcia@iwr.fzk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1101158595 32545 192.168.12.100 (22 Nov 2004 21:23:15 GMT)
X-Complaints-To: abuse@tmr.com
Cc: linux-kernel@vger.kernel.org
To: Ariel Garcia <garcia@iwr.fzk.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <200411221007.47237.garcia@iwr.fzk.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ariel Garcia wrote:
> Hi,
> 
> after i upgraded to  2.6.9 (from 2.6.8-rc4), I started having a similar
> problem to the one somebody else reported on Oct. 27 (thread "SSH and
> 2.6.9"), namely my ssh client hanging soon after doing some cat to
> screen...
> Actually, dissabling CONFIG_LEGACY_PTYS, or SOFTWARE_SUSPEND does not
>  solve the problem for me.
> 
> Also, the problem happens only when i do a ssh to my desktop running also
> 2.6.9 (or at least only in that case it happens fast enough so i can
> trigger it simply by opening the mc or cat'ing something to screen).
> 
> Appended is the strace of the client Andrew requested, details follow.
> 
> Client is OpenSSH_3.8.1p1 Debian-8.sarge.3, OpenSSL 0.9.7d 17 Mar 2004
> on Debian testing/unstable and i have a plain old /dev , no udev or devfs.
> 
> Symptoms:
> 
> - they happen even with a very slow output:
>     while true; do
>          echo -n "a"
>          sleep 1
>     done
> This went ok for the first ~40 chars, then blocked and printed a block of
> ~170chars toghether, this happened twice, then it blocked forever after
> printing a couple of short 8 char long lines (ie, "aaaaaaaa\n")
> 
> - If i kill the forked sshd receiving my connection at the desktop, the
> client at the laptop stays "blocked" (no reaction to keys, escape commands)  
> and it exists after a while with 
> "Read from remote host <desktop>: Connection reset by peer"
> 
> - I can also directly kill the ssh client with a plain kill (kill -15),
>  and it is not in any strange state, just S+ in ps. However, it does not
>  answer to the escape commands (~., ~B, ~*)
> 
> - Actually, i tested also while running a kernel compile, and with that
> load ssh did not hang as fast as without load.
> 
> - tested from Xwin, (konsole, TERM=xterm) but also from a text console,
> TERM=linux, same results
> 
> - scp also hangs with  "0%  0.0KB/s stalled"
> 
> - putting the daemon in debugging mode (ssh -ddd) does not help, i get no
> additional debugging output after the connection is made, but in that case
> the client responds to ~. after the "hang". If i let it stay "hanged"
> however, the daemon sends keepalives, it prints
> debug2: channel 0: request keepalive@openssh.com
> and the connection stays indefinitely.
> 
> - I tested several configurations, between the following machines:
> 
> laptop:  2.6.9 (with or w/o swsuspend and LEGACY_PTYS, plain /dev),
>         Debian, OpenSSH_3.8.1p1
> desktop: 2.6.9 (CONFIG_LEGACY_PTYS=y, plain /dev), Debian, OpenSSH_3.8.1p1
> H:       2.4.27+skas3 (plain /dev), Debian, OpenSSH_3.8.1p1
> U:       2.4.20, RedHat 7.3, OpenSSH_3.1p1
> 
> all work ok except the first one:
> 
> laptop -> desktop: hangs
> laptop -> laptop: OK
> laptop -> {H,U} -> desktop -> desktop: OK
> laptop -> {H,U} -> desktop -> laptop: OK
> desktop -> {H,U}: OK   (day long sessions completely fine)
> 
> 
> Debugging output:
> 
> - I made a "strace -f -o ssh-strace.txt ssh <desktop>"
> Immediately after log in i run:
>     for i in `seq 1 200` ; do echo -n =; done
> the client hanged after 171 chars (but this is not always so, once it
> hanged before giving me the prompt, other time after much more chars),
> then i pressed <enter> once, then i killed the process after a while. You
> can see all this in the attached log (ssh-strace1.txt). (remark that the 3
> "write(5, "==="....) lines near the end of the log add up to exactly 171
> chars)
> 
> - i also attach strace logs made for both the client and the server at the
> same time,
> strace -f -r -o sshd-desktop-strace.txt sshd -D -e -p 24
> strace -f -r -o ssh-laptop-strace.txt ssh artemisa -p 24
> This time i run
>   cat /etc/services
> to hang the client.
> 
> Hope it helps, feel free to request some other test/strace.
> [[ Please, CC directly to me in replys, thanks! ]]
> 
> Sorry, the attachments make the mail bigger than 100K, or are simply not 
> accepted by majordomo... Please, find the files here:
>             http://cvs.fzk.de/~ariel/linux/

I tried this between two 2.6.9-ac4 machines and did not see it. I don't 
know if that's in any way helpful or not :-(

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
