Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130726AbQKCQbf>; Fri, 3 Nov 2000 11:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbQKCQb0>; Fri, 3 Nov 2000 11:31:26 -0500
Received: from gromco.com ([209.10.98.91]:8000 "HELO gromco.com")
	by vger.kernel.org with SMTP id <S130726AbQKCQbM>;
	Fri, 3 Nov 2000 11:31:12 -0500
Message-ID: <3A02E71E.745138F4@gromco.com>
Date: Fri, 03 Nov 2000 11:26:06 -0500
From: Vladislav Malyshkin <mal@gromco.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <39FEF039.69FAFDB2@gromco.com>
		<14846.63285.212616.574188@wire.cadcamlab.org>
		<39FF0A71.FE05FAEB@gromco.com> <14847.51541.625121.78324@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter

> [Vladislav Malyshkin <mal@gromco.com>]
> > Also, the function remove_duplicates can be written using make rules
> > and functions.  Using functions "foreach" "if" from make and
> > comparison you can easily build a function remove_duplicates in make,
> > no shell involved.
>
> Could you please write me this function?  I am curious to see how you
> do it.
>
> I am also a bit skeptical.  About 3 months ago, I thought it would be
> possible to do this, so I spent a few hours fiddling around and reading
> documentation.  I failed; nothing I tried worked.
>
> > so instead of $(sort) your will have $(remove_duplicates) written
> > entirely in make.
>
> That would make me happy.

Absense of recursive macros in make makes the problem not that clear.
An alternative may be if to put \n into variable value,
so the make commands will be automatically generated
---- like this
remove_duplicates = $(2) := ; $(foreach tmpvar1,$(1),$(2) += $$(if
$$(findstring $(tmpvar1),$$($(2))),,$(tmpvar1)); )
$(call remove_duplicates, x y a a c c a b c,ABCD)
--- in this example the variable ABCD is set to the string without
duplicates
but make seems does not allow \n as a value and does not understand
several assignments in one line, so
A = B ; C = D
does not work as expected.

So the best what we can get without using shell is below (the code and
usage example)
The function $(call remove_duplicates,string with duplicates)
removes the duplicates from the string.

# joins four strings
join4 = $(join $(join $(1),$(2)),$(join $(3),$(4)))
# generates indexes
numbers = $(foreach x4,0 1 2 3 4 5 6 7 8 9,\
$(strip $(foreach x3,0 1 2 3 4 5 6 7 8 9,\
$(strip $(foreach x2,0 1 2 3 4 5 6 7 8 9,\
$(strip $(foreach x1,0 1 2 3 4 5 6 7 8 9,\
$(strip $(if $(findstring $(call join4,$(x4),$(x3),$(x2),$(x1)),0000),,\
$(if $(word $(call join4,$(x4),$(x3),$(x2),$(x1)),$(1)),\
$(call join4,$(x4),$(x3),$(x2),$(x1)))))))))))))
# generates indexes
numbers1 = $(wordlist 1,$(words $(wordlist 2,$(words $(1)),$(1))),\
$(call numbers,$(1)))
# Remove duplicates from a line of up to 10000 words
remove_duplicates = $(strip $(firstword $(1)) \
$(foreach tmpvar,$(call numbers1,$(1)),\
$(if $(findstring \
$(word $(tmpvar),$(wordlist 2,$(words $(1)),$(1))),\
$(wordlist 1,$(tmpvar),$(1))),,\
$(word $(tmpvar),$(wordlist 2,$(words $(1)),$(1))))))

f := x x y a b c d x e y jj jj j2 j2 j2 j7
all:
    echo '$(call remove_duplicates,$(f))'



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
