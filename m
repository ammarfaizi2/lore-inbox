Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266029AbUAFAPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266035AbUAFAPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:15:11 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:39327
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S266029AbUAFAO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:14:58 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Vojtech Pavlik <vojtech@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Date: Mon, 5 Jan 2004 18:14:08 -0600
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105201144.GA11179@thunk.org> <20040105210625.GA26428@ucw.cz>
In-Reply-To: <20040105210625.GA26428@ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q3f+/TE1MD6f9EC"
Message-Id: <200401051814.08409.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Q3f+/TE1MD6f9EC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 05 January 2004 15:06, Vojtech Pavlik wrote:
> On Mon, Jan 05, 2004 at 03:11:44PM -0500, Theodore Ts'o wrote:
> > On Mon, Jan 05, 2004 at 12:15:56PM +0100, Vojtech Pavlik wrote:
> > > Mutt with IMAP is rather bearable even on a GPRS connection (40kbps,
> > > 1sec latency). On a 100baseTX it's not distinguishable from local
> > > operation.
> >
> > Hmm... I've tried using mutt/IMAP over GPRS connection, and I find it
> > extremely unpleasant, myself.  My solution is to use isync to provide
> > a local cached copy of the IMAP server on my laptop, and then run mutt
> > against the local cached copy.
> >
> > I have a patch to isync which allows it to issue multiple IMAP
> > commands in parallel (instead of operating in lockstep fashion):
> >
> > http://bugs.debian.org/cgi-bin/bugreport.cgi//tmp/async-imap-patch?bug=22
> >6222&msg=3&att=1
> >
> > With this patch, isync works very well, even over high latency, slow
> > speed links.
>
> That looks very nice. Now, if there were a way how to make the isync
> IMAP connections go over a compressed ssh link (like I'm doing with
> Mutt/IMAP) that'd be very cool.

You can run any tcp/ip service over ssh.

Tell isync that the imap server it's synchronizing with lives on the loopback 
interface, and then run a variant this little python script I use to check my 
email (adjusting the last line for your connection info).  (Note that the far 
end needs netcat.  If you haven't got it, try the version in busybox.)

Yeah, the script's a quick and dirty hack, but really easy to modify.  I have 
a more complicated one using SO_ORIGINAL_DEST and a lookup table if you 
prefer to setup some firewall rules and tell your imap server it lives in the 
192.168.x.x or 10.x.x.x address range...  But I've never gotten around to 
configuring my laptop to use it just to tunnel pop. :)

I keep meaning to put the full solution up on http://dvpn.sf.net, but nobody's 
pestered me about it. :)

Rob

--Boundary-00=_Q3f+/TE1MD6f9EC
Content-Type: text/x-python;
  charset="iso-8859-1";
  name="boing.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="boing.py"

#!/usr/bin/python

import socket,struct,sys,os,signal

vpnip="127.0.0.1"
vpnport=int(sys.argv[1]) # 110 25

signal.signal(signal.SIGCHLD, lambda a,b: os.waitpid(-1,os.WNOHANG))

sock=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
sock.bind((vpnip,vpnport))
sock.listen(10)

while 1:
  try: (conn,addr)=sock.accept()
  except socket.error: continue

  if os.fork():
    conn.close()
    continue

  os.dup2(conn.fileno(),0)
  os.dup2(conn.fileno(),1)
  conn.close()
  sock.close()

  os.execvp("ssh",("ssh","-i","/home/landley/.ssh/id_dsa","landley@66.92.53.140","./netcat","192.168.1.31",str(vpnport)))

--Boundary-00=_Q3f+/TE1MD6f9EC--

