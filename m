Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281171AbRKEPDF>; Mon, 5 Nov 2001 10:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281173AbRKEPC4>; Mon, 5 Nov 2001 10:02:56 -0500
Received: from [195.66.192.167] ([195.66.192.167]:34320 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281171AbRKEPCq>; Mon, 5 Nov 2001 10:02:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robert Love <rml@tech9.net>, Urban Widmark <urban@teststation.com>
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
Date: Mon, 5 Nov 2001 17:01:55 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <01102919120800.05333@nemo> <3BDDA646.B5D0E526@lexus.com> <1004388815.805.11.camel@phantasy>
In-Reply-To: <1004388815.805.11.camel@phantasy>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01110517015501.00794@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert, Urban, everyone,

On Monday 29 October 2001 20:53, you wrote:
> > > I narrowed down Samba weirdness I observe on 2.4.10 to preempt patch.
> > > Plain 2.4.10 works fine, 2.4.10+preempt (with latency measurement
> > > turned on) is sometimes oopses, and sometimes reports 'file already
> > > exists' when I attempt to copy a file from WinNT box to Linux.
> > > Sometimes it works ok (50% or so...)
...
> I use samba myself a _lot_ here and I have not observed any problems,
> even with our older patches... although I don't copy NT->Linux very
> often.

2.4.13+preempt exhibits the same bug (even without latency measurement
patch). 2.4.13 plain is ok.

My subject line is not correct: it has nothing to do with smbfs since
bug shows up when win box creates files on linux share.

nmbd/smbd are started by inetd on my box, and I usually see creation bug
at first attempt to copy file, susequent copies are usually ok.

I have no idea of where I can start planting preempt_disable() and
preempt_enable() in the 2.4.13 to narrow bug location.
Any suggestions? Samba gurus may be more knowledgeable...
--
vda

PS. Urban, I dunno samba mailing list addr, feel free to crosspost this msg
there and/or tell me appropriate email addr.

/etc/inetd.conf (snippet)
-------------------------
# Samba, an SMB server.
netbios-ssn stream tcp nowait root /usr/sbin/smbd
... smbd -l/var/log/samba/smbd.log -s/etc/samba/smb.conf
netbios-ns dgram udp wait root /usr/sbin/nmbd 
... nmbd -l/var/log/samba/nmbd.log -s/etc/samba/smb.conf

(lines with ... have wrapped in kmail)

/etc/samba/smb.conf
-------------------
# VDA
# This setup allows to connect as guest
# (invalid username -> you are guest)
# Attempt to connect to \\server\username
# will ask for password _for that username_
# even on braindamaged clients which don't
# let user specify username. 
#
# Set passwords for users via smbpasswd!
#
# If passwd is ok, you are granted access to /home/username
# Note! To connect under different username, you may need
# to log off and on again on the client machine.
# Yes, M$ is terminally broken.

#======================= Global Settings =====================================
[global]

# Logging
#0..3 - ERR,WARN,NOTICE,INFO
  log file = /var/log/samba.%m
  max log size = 50
  debug level = 1
  syslog = 1
  syslog only = No
  
# Browser elections
  workgroup = LINUXWG
  local master = yes
  domain master = yes 
  preferred master = yes

# Authenticate users using local Samba
# - VDA: ok. Do we need to enable [netlogon]?
# Set passwords for users via smbpasswd!
  encrypt passwords = yes
  security = share
  # This isn't possible with security=share
  ;;domain logons = yes
  os level = 33
  # If username is invalid, treat him as guest
  map to guest = Bad user
  # Allow users with null passwords to connect
  null passwords = yes
  # Allow logins from Win311/95/98 (weaker security)
  lanman auth = yes
  
# Guess what is this?
  client code page = 866
  code page directory = /usr/lib/samba/lib/codepages

# ???
  socket options = TCP_NODELAY 
  
;;
;; TODO: try is this useful
;;[global]
;;  default service = pub
;;
;;[pub]
;;  path = /%S
;;

;;!!!
;;  preexec = ...
;;  postexec = ...

#============================ Default share parameters =======================
  # Map guests to which UNIX user?
  guest account = guest
  # Share is visible by default?
  browseable = yes
  guest ok = yes
  ;;??? browse list = yes
  read only = yes
  follow symlinks = yes
  create mode = 0644
  force create mode = 0600
  directory mode = 0755
  force directory mode = 0111
  deadtime = 10
  
#============================ Share Definitions ==============================
[-root]
  path = /
  read only = yes
  guest ok = yes
  guest only = no

[-pub]
  path = /pub
  read only = yes
  guest ok = yes
  guest only = yes

[-in]
  path = /pub/in
  read only = no
  guest ok = yes
  guest only = yes

# Special share - replaced by username
# Check that this path is actually accessible by users!!!
[homes]
  path = /home/%S
  only user = yes
  user = %S
  guest ok = no
  read only = no
  # This stops [homes] to be visible itself
  # User shares inherit global setting and hence are visible
  browseable = no
