Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbQKNL3U>; Tue, 14 Nov 2000 06:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129936AbQKNL3N>; Tue, 14 Nov 2000 06:29:13 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:26123 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129793AbQKNL2z>;
	Tue, 14 Nov 2000 06:28:55 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
cc: Peter Samuelson <peter@cadcamlab.org>, Torsten.Duwe@caldera.de,
        Chris Evans <chris@scary.beasts.org>, linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit 
In-Reply-To: Your message of "Tue, 14 Nov 2000 10:42:41 -0000."
             <20001114104240.A30388@sable.ox.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Nov 2000 21:58:48 +1100
Message-ID: <2239.974199528@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000 10:42:41 +0000, 
Malcolm Beattie <mbeattie@sable.ox.ac.uk> wrote:
>Keith Owens writes:
>> All these patches against request_module are attacking the problem at
>> the wrong point.  The kernel can request any module name it likes,
>> using any string it likes, as long as the kernel generates the name.
>> The real problem is when the kernel blindly accepts some user input and
>> passes it straight to modprobe, then the kernel is acting like a setuid
>> wrapper for a program that was never designed to run setuid.
>
>Rather than add sanity checking to modprobe, it would be a lot easier
>and safer from a security audit point of view to have the kernel call
>/sbin/kmodprobe instead of /sbin/modprobe. Then kmodprobe can sanitise
>all the data and exec the real modprobe. That way the only thing that
>needs auditing is a string munging/sanitising program.

<spock>Insufficient data, Captain</spock>.  By the time request_module
is called, the code has no idea if the text is valid or not because all
information about where the string came from is in the higher levels.
Using kmodprobe instead of modprobe cannot change that fact.  As long
as the kernel passes user input to modprobe unchanged, any user can
load any module.  Post validation has no way of catching that.

The kernel is allowed to request module names containing '_', '-', '/'
(see devfs) and possibly ' '.  That kills a lot of the sanitisation
attempts.  OTOH, modprobe can detect that its input came from the
kernel and treat it as tainted, forcing the last parameter to be
treated as a module name, even if it contains special characters and
suppressing meta expansion for this "name".  AFAICT, that makes all
kernel input to modprobe safe.  Wait for modutils 2.3.20 then hunt for
any loopholes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
