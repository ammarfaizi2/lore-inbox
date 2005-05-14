Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVENWKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVENWKp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 18:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVENWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 18:10:45 -0400
Received: from coderock.org ([193.77.147.115]:41118 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261513AbVENWKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 18:10:31 -0400
Date: Sun, 15 May 2005 00:10:19 +0200
From: Domen Puncer <domen@coderock.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, kernel-mentors@selenic.com,
       haveblue@us.ibm.com, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment policy
Message-ID: <20050514221019.GA22145@nd47.coderock.org>
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com> <200505041716.j44HGPbV016851@turing-police.cc.vt.edu> <1115227516.22718.4.camel@localhost> <m364xysu0y.fsf@defiant.localdomain> <20050504122836.69205a04.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20050504122836.69205a04.rddunlap@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 04/05/05 12:28 -0700, Randy.Dunlap wrote:
> A couple of days ago, Matt Mackall described/proposed a tool to
> check new patches for acceptable content and format:
>   http://www.selenic.com/pipermail/kernel-mentors/2005-May/000072.html
> 
> I'm attaching a rudimentary version of such a tool (check-patch.pl).
> It does not attempt to check for line wrapping or lines that are
> > 80 characters.

I made a simpler (it's only regexes :-) ) and uglier version, which
does check for line wrapping.
I probably won't have too much time to work on it, so feel free
to do whatever you want with it.

> It dislikes patches that contain attachments that are base64,
> quoted-printable, or binary (e.g.).
> 
> People can run this script locally, but ideally We (royal) will
> have an email address for it so that people can use it to check
> if their mail interface munges the patch for them... :(
> and can try again until it doesn't.

I put mine on patch-tester@coderock.org ... don't abuse it too
much, it's just an old pentium on adsl there :-)


	Domen

--azLHFNyN32YCQGCU
Content-Type: application/x-perl
Content-Disposition: attachment; filename="patch-tester.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0A=0A# checks for:=0A# - [patch] in subject=0A# - encoding =
(no base64, quoted-printable)=0A# - presence of Signed-off-by=0A# - looks -=
p1 appliable?=0A# - "hi/hello/description" strings=0A# - line wrapping=0A# =
- trailing whitespace=0A# - no tabs=0A=0A=0A$header =3D 2;=0A$body =3D 0;=
=0A$warnings =3D 0;=0A$tabcount =3D 0;=0A$signedoffby =3D 0;=0A=0A# update =
this when needed=0A$kroot =3D "(CREDITS|MAINTAINERS|Makefile|README|REPORTI=
NG-BUGS|".=0A	"Documentation\/|arch\/|crypto\/|drivers\/|fs\/|include\/|ini=
t\/|".=0A	"ipc\/|kernel\/|lib\/|mm\/|net\/|scripts\/|security\/|sound\/|usr=
\/)";=0A=0Awhile (<>) {=0A	# skip the first line, there's probably a better=
 way=0A	if ($header =3D=3D 2) {=0A		$header =3D 1;=0A		next;=0A	}=0A=0A	# h=
eader checks=0A	if ($header =3D=3D 1) {=0A		$header =3D 0 if (!/^[a-z\-]+:|=
^[\t ]+/i);=0A		$boundary =3D $1 if (/boundary=3D"([^"]+)"/);=0A		print("To=
:$1\n") if (/^From:(.*)$/i);=0A		print("Subject: [Checked] $1\n") if (/^Sub=
ject: (.*)$/i);=0A=0A		if (/^Subject: (?!.*?\[.*?patch.*?\])/i) {=0A			prin=
t("\nNo [PATCH] in Subject line\n\n");=0A			$warnings++;=0A		}=0A		next;=0A=
	}=0A=0A	$in_boundary =3D 1 if ($boundary && /^--\Q$boundary\E/);=0A	$in_bo=
undary =3D 0 if (/^$/); # hmm... do boundaries always end like this?=0A=0A	=
# don't print boundaries=0A	print("> $_") if ($in_boundary !=3D 1);=0A=0A	i=
f (/^Content-Transfer-Encoding: (quoted-printable|base64)/) {=0A		print("> =
$_\nTeach your mailer not to encode messages.\n\n");=0A		goto err_out;=0A	}=
=0A=0A	# no checks inside boundaries=0A	next if ($in_boundary =3D=3D 1);=0A=
=0A	# between header and patch, description=0A	if ($body !=3D 1) {=0A		$sig=
nedoffby =3D 1 if (/^Signed-off-by:.*<.*\@.*>$/);=0A=0A		# --- is end of bo=
dy marker, but there might be diffstat so +++=0A		if (/^\+\+\+ /) {=0A			$b=
ody =3D 1;=0A			if ($signedoffby =3D=3D 0) {=0A				print("\nThere should be=
 a Signed-off-by:\n\n");=0A				$warnings++;=0A			}=0A		}=0A		if (/^(\+\+\+|=
---) (?![^\/]+\/$kroot|\/dev\/null)/) {=0A			print("\nPatch should be -p1 a=
ppliable.\n\n");=0A			$warnings++;=0A		}=0A		if (/^ *[hH](i|ello)( +\w+)? *=
[,\.\!]? *$/) {=0A			print("\nHi/hello in patch description.\n\n");=0A			$w=
arnings++;=0A		}=0A		if (/^ *[dD]escription *:\s*/) {=0A			print("\n\"Descr=
iption\" in patch description.\n\n");=0A			$warnings++;=0A		}=0A		if (/^-- =
$/) {=0A			print("\nPlease, no .sig in patch description.\n\n");=0A			$warn=
ings++;=0A		}=0A	} else {=0A	# patch=0A		if (!/^([+\- @]|$|diff)/) {=0A			p=
rint("\nLooks like a wrapped line.\n\n");=0A			$warnings++;=0A		}=0A		if (/=
^\+.*[\t ]$/) {=0A			print("\nYou add trailing whitespace.\n\n");=0A			$war=
nings++;=0A		}=0A		if (/\t/) {=0A			$tabcount++;=0A		}=0A	}=0A}=0A=0Aif ($t=
abcount =3D=3D 0) {=0A	print("\nNo tabs detected... this might be ok, but i=
s usualy error\n" .=0A			"  caused by copy&paste from terminal\n\n");=0A	$w=
arnings++;=0A}=0A=0Aif ($warnings !=3D 0) {=0A	print("\n$warnings warnings =
to work on... good luck\n\n");=0A} else {=0A	print("\nPatch seems OK\n\n");=
=0A}=0A=0Aerr_out:=0A#print("If you think output is invalid, mail <domen\@c=
oderock.org>\n");=0A
--azLHFNyN32YCQGCU--
