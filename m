Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263175AbSJFAxh>; Sat, 5 Oct 2002 20:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263179AbSJFAxh>; Sat, 5 Oct 2002 20:53:37 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:55636 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S263175AbSJFAxf>; Sat, 5 Oct 2002 20:53:35 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "Linux Kernel Development List" <linux-kernel@vger.kernel.org>
Subject: Good Idea (tm): Code Consolidation for Functions and Macros that Access the Process Address Space
Date: Sat, 5 Oct 2002 19:58:55 -0500
Message-ID: <000001c26cd3$950ef580$7975d73f@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUBJECT: Good Idea (tm): Code Consolidation for Functions and Macros
that Access the Process Address Space

PROBLEM: Eight (8) functions/macros are near duplicates of, and
equivalent to, other functions/macros that access the process address
space.  Specifically:

	get_user		duplicates get_user_ret
	__get_user		duplicates __get_user_ret
	put_user		duplicates put_user_ret
	__put_user		duplicates __put_user_ret
	copy_from_user	duplicates copy_from_user_ret
	__copy_from_user	duplicates copy_from_user_ret
	copy_to_user	duplicates copy_to_user_ret
	__copy_to_user	duplicates copy_to_user_ret

EXPLAINATION: One functional difference exists between the
functions/macros with "_ret" and those without: functions/macros with
"_ret" return an error code; those without "_ret" return void.

Since the only difference is whether or not an error code is returned,
the functions/macros can be used interchangeably.

Remember, if a function call has no place for a returned value to go,
nothing bad happens; the returned value is simply ignored/discarded.

WHY THIS SHOULD BE CHANGED:
1) Easier to maintain code (because there's less of it to maintain).
2) Less code means smaller kernel.
3) Forces better coding structures and procedures (because no matter
which function the user will choose under the new system, an error code
will always be returned).
4) Is backward compatible with all existing code.
5) The solution can be seamlessly integrated.
6) The overhead for returning an error code is nominal.

SOLUTION:

Use the #define Preprocessor Directive for Symbolic Constants.  Here's
some sample code:

	#define get_user get_user_ret
	#define __get_user __get_user_ret
	#define put_user put_user_ret
	#define __put_user __put_user_ret
	#define copy_from_user copy_from_user_ret
	#define __copy_from_user copy_from_user_ret
	#define copy_to_user copy_to_user_ret
	#define __copy_to_user copy_to_user_ret

By placing that code in the appropriate header file(s), the #define
statements will trickle down to the appropriate source files.

Hence the functions/macros without "_ret" can be eliminated, resulting
in code consolidation.

NOTE: The validity of using a #define Preprocessor Directive as a
Symbolic Constant on a function has been tested, and proven viable, in
the following sample program:

#include <iostream>
using std::cout;
using std::cin;
using std::endl;

void Hello();
void Hello_Again();

#define Hi Hello
#define Hi_Again Hello_Again

/*
void Hi();
void Hi_Again();
*/

int main() {
	Hello();
	Hello_Again();
	Hi();
	Hi_Again();
}

void Hello () {
	cout << "Hello." << endl;
}

void Hello_Again() {
	cout << "Hello, again." << endl;
}

/*
void Hi() {
	cout << "Hi." << endl;
}

void Hi_Again() {
	cout << "Hi, again." << endl;
}
*/


