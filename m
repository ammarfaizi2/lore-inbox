Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132157AbQLZXox>; Tue, 26 Dec 2000 18:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132173AbQLZXon>; Tue, 26 Dec 2000 18:44:43 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:33542 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132157AbQLZXo2>;
	Tue, 26 Dec 2000 18:44:28 -0500
Date: Tue, 26 Dec 2000 18:13:11 -0500
Message-Id: <200012262313.eBQNDBi07719@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Tim Wright <timw@splhi.com>, Kai Henningsen <kaih@khms.westfalen.de>,
        André Dahlqvist <anedah-9@sm.luth.se>,
        Giacomo Catenazzi <cate@student.ethz.ch>, linux-kernel@vger.kernel.org,
        linux-kbuild@torque.net
Subject: How do we handle autoconfiguration?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, replying to Alan:
>> If we do that I'd rather see a make autoconfig that does the lot from
>> proc/pci etc 8)
>
>Good point. No point in adding a new config option, we should just have a
>new configurator instead. Of course, it can't handle many of the
>questions, so it would still have to fall back on asking.

Andre forwarded this to me, asking:
>Would this sort of auto-configuration be difficult to implent in [CML2]?

Summary answer: 

CML2 doesn't handle this now -- and I'd prefer for it not to, as I
think a separate batch-mode autoconfigurator feeding its results to
CML2 as a partial config would be better design.  But it could be done
without much difficulty.

Detailed answer:

My original design for CML2 included a way to capture the results from
arbitrary procedural probes written in C or some scripting language
and use them in predicates.  Imagine something like this:

# PROCESSOR is string valued; we capture stdout from the probe
derive PROCESSOR from "myprobe1.sh"

# FOOFEATURE is boolean; we look at the return status from myprobe2.py 
derive FOOFEATURE from "myprobe2.py"

Alan, with simple probes that investigate proc/pci this would do exactly
what you want.  Such a feature would be easy to implement in CML2.  With 
a little work, I could even support inline probe procedures declared
in the rules file itself.

I backed away from this because Giacomo Catenazzi told me he was
working on a separate autoconfigurator that would generate config
files in CML1 format.  That's a cleaner design -- one would run his
autoconfigurator and then import the resulting config into the CML2
configurator as frozen (immutable) symbols.  Giacomo, what's the state 
of your project?

(kbuild people, this is one reason I want ifdefs gone from the
makefiles.  The autoconfigurator, whether it's Giacomo's or not,
should be able to pass FOO=n to tell CML2 that a given feature is
definitely not present.)

For later:

If Giacomo's attempt at an autoconfigurator fails, I will tackle
this problem -- but only with CML2 adopted and in place first.  
Otherwise handling all the grotty CML1 details would be just
too nasty.
--
						>>esr>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
