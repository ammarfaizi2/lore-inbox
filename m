Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313451AbSDLI3Z>; Fri, 12 Apr 2002 04:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313452AbSDLI3Y>; Fri, 12 Apr 2002 04:29:24 -0400
Received: from mail.ekh.no ([213.184.194.22]:50449 "EHLO romeo.skybert.no")
	by vger.kernel.org with ESMTP id <S313451AbSDLI3Y>;
	Fri, 12 Apr 2002 04:29:24 -0400
Date: Fri, 12 Apr 2002 10:29:05 +0200 (CEST)
From: =?iso-8859-1?Q?Erik_Inge_Bols=F8?= <erik@tms.no>
To: Urban Widmark <urban@teststation.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.20 umount oops (probably smbfs related)
In-Reply-To: <Pine.LNX.4.33.0204112117400.21322-100000@cola.teststation.com>
Message-ID: <Pine.LNX.4.30.0204121003210.25377-100000@romeo.skybert.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.0-pre6-clm-rl-8 (http://amavis.org/)
X-AntiVirus: scanned for viruses by AMaViS 0.2.0-pre6-clm-rl-8 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Urban Widmark wrote:
> On Tue, 9 Apr 2002, Erik Inge Bolsø wrote:
> > >>EIP: c0126389 <fput+5/48>
> > Trace: c012914e <do_umount+ee/144>
> > Trace: c01291f8 <umount_dev+54/9c>
> > Trace: c01292ed <sys_umount+ad/bc>
> > Trace: c0129308 <sys_oldumount+c/10>
> > Trace: c0109144 <system_call+34/38>
> > Code:  c0126389 <fput+5/48>                    00000000 <_EIP>: <===
> > Code:  c0126389 <fput+5/48>                       0:	8b 43 1c             	movl   0x1c(%ebx),%eax <===
>
> Your trace doesn't include any smb_ references, but I suppose the cd8ef644
> ones might be. I don't see where do_umount calls fput so ...

Right. Seems that the somewhat ancient ksymoops (0.6e) didn't pick up the
smbfs module's symbols. Will update.

> This is usually bad and you may want to investigate why it died/upgrade
> your samba version regardless of the patch below. Recent smbmounts can log
> to file and with a suitable debuglevel you may find out what happened
> (debug=4 or so).

Thanks for the tip. Upgrading the 2.0.6 to 2.0.10 ASAP.

> > smb_lookup: find //email.txt failed, error=-5
> > smb_get_length: recv error = 512
> > smb_request: result -512, setting invalid
> > smb_dont_catch_keepalive: did not get valid server!
>
> smbfs unmount code "put_super" does:
> 	if (server->sock_file) {
> 		smb_proc_disconnect(server);
> 		smb_dont_catch_keepalive(server);
> 		fput(server->sock_file);
> 	}

<snip good explanation>

Aha! I traced it as far as these lines myself yesterday, but couldn't
figure out what nulled sock_file, and why. Thanks!

> If that is what happened the patch below should help. It simply changes
> smbfs not to try and send a disconnect message if it isn't connected.
> Which makes sense anyway, no need to connect just to say goodbye. Even if
> that may the polite thing to do :)

Thanks, will try the patch as soon as I find time to rebuild. Looks sane
:)

> > Note that the smb share in question is mounted, alive and well as of this
> > moment, I can read files on it just fine - it's just the umount of it that
> > oopsed.
>
> Sounds strange. Could that be some automounter that mounted another one
> for you?

Could be, I suppose. No automounter running, but the script that oopsed is
run once an hour and does an umount/mount to deal with the windows server
being rebooted - we want the share to stay mounted, no matter if we reboot
the old NT4 box. (If we reboot it and don't do this, we get I/O errors on
accessing the mount point.)

-- 
Erik I. Bolsø, Triangel Maritech Software AS | Skybert AS
Tlf: 712 41 694		Mobil: 915 79 512

