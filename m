Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSBJAUL>; Sat, 9 Feb 2002 19:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSBJAUD>; Sat, 9 Feb 2002 19:20:03 -0500
Received: from [63.231.122.81] ([63.231.122.81]:52840 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S289015AbSBJATp>;
	Sat, 9 Feb 2002 19:19:45 -0500
Date: Sat, 9 Feb 2002 17:19:19 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Message-ID: <20020209171919.D9826@lynx.turbolabs.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020209181213.GA32401@come.alcove-fr> <Pine.LNX.4.33.0202091241080.1196-100000@home.transmeta.com> <20020209201252.GD32401@come.alcove-fr> <20020209122649.E13735@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020209122649.E13735@work.bitmover.com>; from lm@bitmover.com on Sat, Feb 09, 2002 at 12:26:49PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 09, 2002  12:26 -0800, Larry McVoy wrote:
> This is my problem.  You could help if you could tell me what exactly 
> are the magic wands to wave such that you can ssh in without typing
> a password.  I know about ssh-agent but that doesn't help for this, 
> I know that in certain cases ssh lets me in without anything.  I thought
> there was some routine where you ssh-ed one way and then the other way
> and it left enough state that it trusted you, does any ssh genuis out 
> there know what I'm talking about?  If I have this, I can set up the
> cron job, I'm sure this is obvious and I'm just overlooking something
> but I can't find it.

OK, so to log in or run a command on a remote machine R, from your local
machine L, you need to have a copy of your public key L:~/.ssh/identity.pub
in the file R:~/.ssh/authorized_keys.  You can have multiple keys in
R:~/.ssh/authorized_keys.  When ssh'ing from L to R, you also need to
have L:~/.ssh/identity available and possibly type in a pass-phrase if
needed (for automated systems you probably do not want a pass-phrase,
so you set it up with its own key).

Just FYI, the rest of the story goes like:

If your L:~/.ssh/identity has a pass-phrase (or if you want to do multi-
hop ssh'ing, I think) you will probably want to use an ssh-agent to hold
all of your private keys.  GDM (Gnome X login) will start ssh-agent for
you I believe, and then you have to do "ssh-add [identity file ...]" to
add one or more private keys to the ssh-agent, which will prompt you for a
pass-phrase if needed.  If you have multiple private keys (identity files)
then newer versions of ssh-add will try the same pass-phrase for all of
them before prompting you again.

Then, when you ssh over to another machine, and that machine is listed
in /etc/ssh/ssh_config or .ssh/config as "ForwardAgent yes" it will
pass on your private key(s) to a new agent started on the remote machine,
which will allow you to do passwordless ssh to another machine, etc.
Likewise, as long as you have "ForwardX11 yes" for each machine in the
chain, you will be able to start an X session at the far end and it
will tunnel through all of the ssh hops to display on L's screen.

You probably want to have a pass-phrase on all of your private keys,
because if anyone ever could read your ~/.ssh/identity file, they can
effectively do anything you can do, and connect anywhere that has your
corresponding identity.pub file in the authorized_keys file without
a password.

Note also, for most new versions of SSH, it will try SSH protocol 2
before it tries SSH 1.  This means that everywhere I said "identity"
it will use "id_dsa", "identity.pub" becomes "id_dsa.pub", and
"authorized_keys" becomes "authorized_keys2".  You can change the default
order if you want with "Protocol 1,2" in your ~/.ssh/config file, or
you can add both your L:~/.ssh/identity and L:~/.ssh/id_dsa to the
ssh-agent, and add the id_dsa.pub to authorized_keys2.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

