Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136612AbRECKQA>; Thu, 3 May 2001 06:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136669AbRECKPl>; Thu, 3 May 2001 06:15:41 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:2058 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136612AbRECKPe>;
	Thu, 3 May 2001 06:15:34 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard 
In-Reply-To: Your message of "Thu, 03 May 2001 03:47:55 -0400."
             <20010503034755.A27693@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 20:15:26 +1000
Message-ID: <15180.988884926@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001 03:47:55 -0400, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>OK, so you want CML2's "make oldconfig" to do something more graceful than
>simply say "Foo! You violated this constraint! Go fix it!"

(i) Start with a valid config.  CML2 will not allow any changes that
    violate the constraints.  Not a problem.

(ii) Start with a invalid config.  CML2 makes best effort at correcting
     it.

     (a) Interactive mode (menuconfig, xconfig) - tell the user to fix
         it.

     (b) Batch mode (oldconfig).  Attempt to automatically correct the
         config using these rules.

        (1) Earlier constraints take priority over later constraints.
            That is, scan the constraints from top to bottom as listed
            by the rules.

        (2) For valid constraints, freeze all variables in the
            constraint, both guard and dependent.

        (3) For failing constraints, freeze the guard variables, change
            the dependent variable to satisfy the constraint then
            freeze it.

        (4) If a dependent variable is already frozen then give up,
            human intervention is required.  This includes any
            variables that are changed as side effects of updating a
            dependent variable.

        (5) Backtracking is required between (4) and (3) if the
            dependent variables in (3) can take more than one value.
            For example with RTC!=n then set RTC=y, freeze it and try
            to complete the remaining constraints.  If you cannot find
            a consistent set of values, unfreeze all variables from the
            later constraints, unfreeze RTC, set RTC=m, freeze and go
            forward again.

>Worst-case you wind up having to filter 3^1976 or
>
>61886985104344314262549831301497223184442226760005632366142367454062\
>53798069007245829607511803014461980205195265648765807533359692422405\
>26663343478651948197640717559171334587246360190820597462466618699616\
>83769466038480440588536443139761873343981834731232898868121056624288\
>25175698197266097855144317654507849536499564272166336474891989097438\
>35187399533347347604275259693285565328638904436467418552386274533685\
>91327533953419273284845915678229675363862482902467758788105098892672\
>89040426968478652648633090613090819909922898996729964073665423236084\
>87819939319685920863027286269975666073166040062426792612975756185462\
>81534154977458915332736966975415596732075433912438120798023875787687\
>12139869442963906795755406077094024235937984546041146032870399467676\
>50750114775766120549985366981610796100249952621482595580440335923663\
>89536648507944663518188694691546583650254496327051865064380044199561\
>11898186436375597975714968012719658007155903874756222061921

bc is a wonderful tool :)

Worst case with my algorithm is the product of the number of possible
values that each dependent variable can take over all constraint rules.
In the vast majority of cases, there is only one possible value, either
because the constraint is already valid or because the dependency
requires a single value.  So the number of possible cases to test is
governed by how many rules use != or < or > instead of ==.

Is this perfect?  No, you can construct pathological constraints that
involve a lot of backtracking and even then there may be no valid set
of values.

Do we care?  No, we do not write rules like that.

