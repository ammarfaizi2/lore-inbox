Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUHTKPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUHTKPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHTKPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:15:55 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:661 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266212AbUHTKPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:15:12 -0400
Subject: Re: Interesting race condition...
From: Lee Revell <rlrevell@joe-job.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Rob Landley <rob@landley.net>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729235654.GA19664@k3.hellgate.ch>
References: <200407222204.46799.rob@landley.net>
	 <20040729235654.GA19664@k3.hellgate.ch>
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1092996907.10063.91.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 06:15:09 -0400
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 19:56, Roger Luethi wrote:
> On Thu, 22 Jul 2004 22:04:46 -0500, Rob Landley wrote:
> > I just saw a funky thing.  Here's the cut and past from the xterm...
> > 
> > [root@(none) root]# ps ax | grep hack
> >  9964 pts/1    R      0:00 grep hack HOSTNAME= SHELL=/bin/bash TERM=xterm HISTSIZE=1000 USER=root LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=
> > [root@(none) root]# ps ax | grep hack
> >  9966 pts/1    S      0:00 grep hack
> > 
> > Seems like some kind of race condition, dunno if it's in Fedore Core 1's ps
> > or the 2.6.7 kernel or what...
> 
> If somebody posted a solution for this, I didn't see it. There's a race in
> the kernel, and considering the permissions on /proc/PID/{cmdline,environ}
> a security bug as well: If you win the race with a starting process, you
> can read its environment.
> 
> This should plug the hole. Can you give it a spin?
> 

Was this ever merged?  I just hit this bug with 2.6.8.1:

rlrevell@mindpipe:~$ ps auxww | grep jack
rlrevell 10498  0.1  5.9 28656 28624 pts/0   SLl+ 06:07   0:00 jackd -n 1000000 --realtime -d alsa --rate 48000 -D -P hw:0,0 -C hw:0,2 -p 32 -S
rlrevell 10502  0.1  2.3 11432 11432 pts/2   SLl+ 06:07   0:00 jack_simple_client foo
rlrevell 10509  0.0  0.0     4    4 pts/1    R+   06:09   0:00 grep jack SSH_AGENT_PID=667 TERM=rxvt SHELL=/bin/bash CVSROOT=:pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa GTK_RC_FILES=/etc/gtk/gtkrc:/home/rlrevell/.gtkrc-1.2-gnome2 WINDOWID=33554437 USER=rlrevell LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35: GNOME_KEYRING_SOCKET=/tmp/keyring-oFgJ2h/socket SSH_AUTH_SOCK=/tmp/ssh-JvFuVGV623/agent.623 SESSION_MANAGER=local/mindpipe:/tmp/.ICE-unix/623 USERNAME=rlrevell DESKTOP_SESSION=default PATH=/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games PWD=/home/rlrevell GDMSESSION=default HISTCONTROL=ignoredups HOME=/home/rlrevell SHLVL=1 GNOME_DESKTOP_SESSION_ID=Default LOGNAME=rlrevell DISPLAY=:0.0 COLORTERM=rxvt XAUTHORITY=/home/rlrevell/.Xauthority _=/bin/grep /bin/grep    
rlrevell@mindpipe:~$ ps auxww | grep jack
rlrevell 10498  0.1  5.9 28656 28624 pts/0   SLl+ 06:07   0:00 jackd -n 1000000 --realtime -d alsa --rate 48000 -D -P hw:0,0 -C hw:0,2 -p 32 -S
rlrevell 10502  0.1  2.3 11432 11432 pts/2   SLl+ 06:07   0:00 jack_simple_client foo
rlrevell 10511  0.0  0.0  1576  464 pts/1    S+   06:09   0:00 grep jack
rlrevell@mindpipe:~$ ps auxww | grep jack
rlrevell 10498  0.1  5.9 28656 28624 pts/0   SLl+ 06:07   0:00 jackd -n 1000000 --realtime -d alsa --rate 48000 -D -P hw:0,0 -C hw:0,2 -p 32 -S
rlrevell 10502  0.1  2.3 11432 11432 pts/2   SLl+ 06:07   0:00 jack_simple_client foo
rlrevell 10513  0.0  0.0   240  124 pts/1    R+   06:09   0:00 grep jack
rlrevell@mindpipe:~$ ps auxww | grep jack
rlrevell 10498  0.1  5.9 28656 28624 pts/0   SLl+ 06:07   0:00 jackd -n 1000000 --realtime -d alsa --rate 48000 -D -P hw:0,0 -C hw:0,2 -p 32 -S
rlrevell 10502  0.1  2.3 11432 11432 pts/2   SLl+ 06:07   0:00 jack_simple_client foo
rlrevell 10515  0.0  0.0  1576  464 pts/1    S+   06:09   0:00 grep jack
rlrevell@mindpipe:~$ ps auxww | grep jack

Lee


