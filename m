Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264491AbTCXW3g>; Mon, 24 Mar 2003 17:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264492AbTCXW3g>; Mon, 24 Mar 2003 17:29:36 -0500
Received: from main.gmane.org ([80.91.224.249]:57995 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S264491AbTCXW31>;
	Mon, 24 Mar 2003 17:29:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Raja R Harinath <harinath@cs.umn.edu>
Subject: Re: [CHECKER] potential dereference of user pointer errors
Date: Mon, 24 Mar 2003 16:28:06 -0600
Organization: Dept. of Computer Science, Univ. of Minnesota
Message-ID: <d9llz4v1qh.fsf@bose.cs.umn.edu>
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:tx2ZOorpHaO7yDLdMgCOgIg7euc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Junfeng Yang <yjf@stanford.edu> writes:

> We are the the Stanford Checker team that constantly send error
> reports to the linux kernel mailing list. Enclosed are 10
> dereference of user pointer warnings catched by our checker. We
> started by marking the second parameter of copy_from_user (to, from,
> len), the first parameter of copy_to_user (to, from, len), and all
> parameters of the sys_* functions as tainted, then propogated the
> tainted annotations along call chains. If two functions get assigned
> to the same structure field, we propogate the tainted annotations
> between them, too. An example of such propogation is the warning
> about drivers/media/video/cpia.c::cpia_write_proc and
> drivers/media/usb/media/vicam.c. The error message uses "thru
> struct_name:field_name" to represent such propogations.

Can't pointer-dereference errors be handled directly by any C
compiler.  Is CHECKER necessary for this.  Use an incomplete
struct pointer and the compiler will complain on all dereferences.

Something like

  /* struct user_space should never be defined.  */
  typedef struct user_space user_space;

  int copy_to_user (user_space *to, char *from, size_t len);
  int copy_from_user (char *to, user_space *from, size_t len);
  /* ... */

  #define TREAT_AS_USER_SPACE_POINTER(p) \
            ({                                  \
              BUG_ON(get_fs() != get_gs());     \
              (user_space *)p;                  \
            })

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu

