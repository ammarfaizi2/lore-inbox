Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286532AbRL0Tqd>; Thu, 27 Dec 2001 14:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286557AbRL0TqZ>; Thu, 27 Dec 2001 14:46:25 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:9583 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S286556AbRL0TqL>; Thu, 27 Dec 2001 14:46:11 -0500
Posted-Date: Thu, 27 Dec 2001 19:46:03 GMT
Date: Thu, 27 Dec 2001 19:46:03 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Configure.help editorial policy
In-Reply-To: <20011227003917.GA17344@msp-150.man.olsztyn.pl>
Message-ID: <Pine.LNX.4.21.0112271920450.3044-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik, Eric.

>>> Alternatively, deal with this problem the same way the "This may
>>> also be built as a module..." comment is - either include it several
>>> thousand times in Configure.help or (better still) have the
>>> configuration tools spit it out automatically every time the need
>>> for it crops up. The following ruleset could easily be implemented
>>> even in the `make config` and `make menuconfig` parsers, and should
>>> be just as easy in CML2. Applying rule (1) will result in a
>>> considerable reduction in the size of the file
>>> Documentation/Configure.help as it currently stands.

>> I have said before; I am *not* going to make KB vs. KiB a
>> metaconfiguration option -- that would defeat the whole purpose of
>> having standard terminology. That decision is final, and this
>> subject is closed.

No such suggestion has come from me.

> With all due respect, Eric, I think you misunderstood. The way I
> understand it, Riley is simply proposing to automatically _attach_
> an explanation of the KB/KiB confusion to help text of every option
> that uses these units.

That is exactly what I'm proposing Dominik - and the patches to do this
for `make config` are all ready for distribution, as are the basic
patches for Configure.help itself. I'm working on the patches for `make
menuconfig` at the moment, and will be doing those for `make xconfig`
once those are complete. Once that's done, CML2 will be the only config
tool not supporting it - and that's Eric's decision, not mine.

>> The other is not a bad idea in principle. I've thought before about
>> adding a feature that would add specified boilerplate to the help a
>> tristate symbol, for exactly the reasons you suggest. Three things
>> make it a bit messy in practice.
>>
>> One is that it would have to be expressed in the rulebase, ruther
>> than wired into the code. I will not hardwire specific knowledge
>> about the Linux-specific properties of tristate symbols into the
>> CML2 engine. CML2 is already being used by at least two projects
>> other than the kernel and I know of a third that has it under
>> consideration. Therefore I must preserve its generality.

> Fair enough. I don't think anyone would want you to make it
> Linux-specific.

I'm certainly not planning on doing so. The changes to `make config` are
on the basis that help requests from the "tristate" or "dep_tristate"
commands automatically adds whatever is attached to the help variable
DEFINE_MODULAR to the end of the help text for the option named. There's
absoultely nothing in that logic that has any more relevance to Linux
than to any other project using the same config toolsets.

>> The second problem is that the module boilerplate is not all
>> boilerplate. Most instances contain the name of the generated module
>> object file. Thus, to do this right, I would have to declare module
>> names in the rulebase, one for each tristate entry. This implies a
>> significant extension to the CML2 language, which I'm reluctant to
>> do right now. The design is stable. I want it to stay that way until
>> (at least) well after CML2 achieves acceptance.

This is already dealt with in the design I'm using. It requires that the
statement naming the module appears as the last line of the boilerplate
after the standard text, but that is already the case for several of the
uses of the "I can be a module" text, and the others can easily be
converted to use the same.

>> Third, I don't want to do major surgery on Configure.help until
>> after CML2 enters the tree. Were I to do so, I would then have to
>> maintain two different versions of Configure.help. That would be too
>> big a pain.

>> Therefore, I'm going to defer consideration of this feature for now.
>> I certainly will not consider it until after CML2 goes into the 2.5
>> tree, and may not consider it until there is some kind of final
>> decision on a 2.4 backport.

You may soon be in the position of having to maintain two different
versions of Configure.help if you don't implement this feature, rather
than if you do, as the code to implement it in the existing config tools
is well under way, and `make config` is ready for testing.

> Again, these are all valid points. I guess you could just put this
> idea far on the TODO list for now. :-) Same thing applies to the
> first part of Riley's proposition, it would seem.

Alternatively, you could have a look at what is actually required. Here
is a summary of the requirements that proved necessary for `make config`
to add boilerplate text to those options that can be selected as being
modular in the current tree:

 1. The help function is split up into three...

	extract_help help-var

		This extracts the help text associated with the
		help variable specified.

	extract_all_help help-var...

		This extracts the help text associated with all
		of the help variables named, and appends it all
		end to end in the order specified. It does so by
		calling extract_help for each argument in turn.

	help help-var...

		This passes its arguments to extract_all_help and
		then arranges for the resulting text to be shown
		to the user.

 2. The places in the tristate and dep_tristate functions where the help
    function is called get an extra fixed parameter of DEFINE_MODULAR in
    each case.

 3. The relevant help text is added to the Configure.help file.

That's it - the sum total changes required. Essentially the same changes
are needed to get `make menuconfig` to do the same thing, but step (2)
is a little more tricky in this case. I haven't looked at `make xconfig`
yet, but that is unlikely to differ much from the above.

Once these changes are made, the additions to deal with adding other
boilerplate for technical acronyms appropriate to the project in
question are restricted to the Configure.help file itself and the
extract_all_help function included above, and nothing else will need
changing.

Incidentally, the changes to Configure.help in the current patches use
empty boilerplate text, so the addition of the relevant lines in
Configure.help to prevent it spewing out error messages results in a
Configure.help file compatible with both the old and revised system.

Best wishes from Riley.

