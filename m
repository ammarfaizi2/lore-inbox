Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbRFZCfL>; Mon, 25 Jun 2001 22:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264879AbRFZCew>; Mon, 25 Jun 2001 22:34:52 -0400
Received: from [192.48.153.1] ([192.48.153.1]:36115 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S264883AbRFZCep>;
	Mon, 25 Jun 2001 22:34:45 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Mon, 25 Jun 2001 12:22:29 CST."
             <200106251822.f5PIMTU05229@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 12:34:03 +1000
Message-ID: <5557.993522843@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001 12:22:29 -0600, 
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>Keith Owens wrote:
>>(2) Generated files must not be overwritten in place.
>>
>>    When "gen" is shipped and also overwritten in place then anybody
>>    who regenerates the file (for whatever reason) runs the risk of
>>    spurious differences appearing in their patches.  Particularly when
>>    the generating process depends on tools which can vary from one
>>    user to another.
>
>I think this is the crux of our where we disagree.  The generated file
>in this case should only be overwritten by those developing the driver.
>We've already agreed that the mechanism used in 6.1.5 of the aic7xxx
>driver (always regenerage) cannot work.  Therefore the predominant
>case, and in my opinion the only case you need to concern yourself with,
>is building the kernel from the vendor generated file.
>
>In this scenario, I would argue that overwriting the files in place
>is the correct strategy.  For the developer that choses to build
>the firmware, timestamp based "up to date" behavior is correct,
>the last firmware file you've generated/tested is already in the correct
>place for generating patches, and, as a developer, you understand
>how to use your revision control software so the fact that this file
>is generated is not a concern.

I think you are missing an important point.  Once the developer issues
a patch, that patch becomes part of everyone's source tree.  So
_everyone_ ends up changing the generated files, at which point they
run into the timestamp and source repository problems.  Overwriting in
place works for the developer but it causes problems for the rest of
the world.  The rest of the world can never guarantee that their
timestamps match the developer's timestamps, in fact you can almost
guarantee that they don't.

<emp>
  Any timestamp check in kbuild is unreliable when generated files are
  shipped and then updated in place, even if nobody except the
  maintainer ever changes the generated file.  Distributing a patch has
  exactly the same effect on timestamps as changing the generated file.
</emp>

You want timestamp checks for aic7xxx firmware, but including those
checks in kbuild will hit everyone else the moment they apply your
latest patch.  We either fix the dependency problem so it works for
everyone or we remove all dependency checking on aic7xxx firmware
generation.  Fixing the problem for everyone is my preferred option
because it gives better support for people working on the firmware.
Timestamps on generated and shipped files cannot reliably detect if
"base" and "gen" are in sync or not, hence the use of md5sum.

