Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130668AbQKNGVl>; Tue, 14 Nov 2000 01:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbQKNGVb>; Tue, 14 Nov 2000 01:21:31 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:63245 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130668AbQKNGVV>; Tue, 14 Nov 2000 01:21:21 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Torsten.Duwe@caldera.de, Chris Evans <chris@scary.beasts.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit 
In-Reply-To: Your message of "Mon, 13 Nov 2000 23:02:10 MDT."
             <20001113230210.F18203@wire.cadcamlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Nov 2000 16:50:19 +1100
Message-ID: <3864.974181019@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000 23:02:10 -0600, 
Peter Samuelson <peter@cadcamlab.org> wrote:
>
>[Torsten Duwe]
>> +	for (p = module_name; *p; p++)
>> +	{
>> +	  if (isalnum(*p) || *p == '_' || *p == '-')
>> +	    continue;
>> +
>> +	  return -EINVAL;
>> +	}
>
>I think you just broke at least some versions of devfs.  I don't
>remember if the feature is still around, but I know it *used* to be
>possible to request_module("/dev/foobar"), which requires '/' in the
>name.

That feature of devfs is definitely still around, it is critical to
devfs.

All these patches against request_module are attacking the problem at
the wrong point.  The kernel can request any module name it likes,
using any string it likes, as long as the kernel generates the name.
The real problem is when the kernel blindly accepts some user input and
passes it straight to modprobe, then the kernel is acting like a setuid
wrapper for a program that was never designed to run setuid.

At the very least, interface names which are taken directly from the
user should be prefixed with "user-interface-" before being passed to
modprobe.  The sysadmin can set "alias user-interface-eth0 eth0" if
they want to use this feature.  Passing the interface name unchanged is
asking for trouble, as Chris Evans pointed out, you can abuse this
"feature" to load any module.

I have nearly finished the security review of modutils, 2.3.20 will be
out later tonight.  It treats the kmod environment as tainted, forces
the last parameter to be treated as a module name even if it starts
with '-', only accepts one module name and refuses 'variable=value'
strings.  I find it rather ironic to be treating kernel supplied data
as tainted.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
