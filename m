Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313123AbSDIKRg>; Tue, 9 Apr 2002 06:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSDIKRf>; Tue, 9 Apr 2002 06:17:35 -0400
Received: from oe37.law9.hotmail.com ([64.4.8.94]:55300 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S313123AbSDIKRe>;
	Tue, 9 Apr 2002 06:17:34 -0400
X-Originating-IP: [66.108.18.44]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: C++ and the kernel
Date: Tue, 9 Apr 2002 06:16:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE379mspgEOI7vDcPp200002a4c@hotmail.com>
X-OriginalArrivalTime: 09 Apr 2002 10:17:28.0790 (UTC) FILETIME=[C0ACB760:01C1DFAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    I am in the initial stages of writing some C++ wrapper classes for the
kernel.  So far its been an interesting process, mainly due to the use of
some C++ keywords in the kernel header files.  Mostly gratuitous at that as
most of the C++ keyword uses I've encountered so far are the use of the
keyword "new" as variable names in some inlined functions.  Well I've fixed
up the header files (I've used so far) and have been able to successfully
overload the new and delete keywords thus allowing me to properly construct
and deconstruct C++ objects within a kernel module.  Well I've encountered a
couple of issues I hope someone can help me here.

    So far my overloading of "new" works if I compile the module without
exceptions (-fno-exceptions).  This is fine for myself as I prefer checking
for a NULL on a memory allocation error over handling an exception, plus the
resulting code appears to be much more efficient without exceptions by a
large order of magnitude.  However I would like my C++ kernel support to
include exception support if possible so those whom may want to use it,
besides which it may yet prove itself useful.  However allowing exceptions
in (if used apparently, via so far my overloading of "new") appears to put
an undefined reference to throw and (I think) terminate into the resulting
object file.  Does someone know how I can resolve this?

    I would like to add the ability for the wrapper classes' users to use
static member functions as the module initiation and cleanup functions.  For
example:

class my_module
{
    public:
        static int load();
        static void unload();
};

    And use my_module::load() as the init_module function and
my_module::unload() as the cleanup_module function.  The provided macros
module_init and module_exit should do this for me however I've encountered a
limitation in how gcc's "alias" feature is used.  Apparently for C++ one
must pass the mangled name of the function in question.  Is there a gcc
macro or function of some kind to do something like this:

int init_module() __attribute__((alias(mangle_name("load__9my_module"))));
int cleanup_module()
__attribute__((alias(mangle_name("unload__9my_module"))));

    I need a function or macro like mangle_name above.

    Another issue that I currently have is that I haven't been able to
figure out a way to get the module to properly initiate global objects.
Like so:

my_module mod1;

    If I put this in the source file as a global function and load the
module, I've found that this module's constructor doesn't get called.  I
figured out why and gcc's documentation backed me up.  However I can't seam
to find any way to tell gcc to initiate the object file's global objects
from within the init_module function.  I know a workaround would be to have
a pointer instead and allocate the object in init_module however I think its
best to avoid pointers whenever possible to reduce the chance of errors.
Anyone know how I can get gcc to insert the global initiation code from
within init_module?


On a side note:

    So far C++'s use of the kernel headers has found a couple of areas in
which possible bugs exists.  In one header file the typedef ssize_t is used
despite its definition not appearing in the source file or any of the
included header files.  I've also encountered negative numbers being
assigned to unsigned numbers without a cast.  And I've found completely
unnecessary use of the C++ keyword "new" as variable names in some inlined
functions.

    Would patches be welcomed for one or more of these issues?

    Thanks.
