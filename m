Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271332AbRIFQY0>; Thu, 6 Sep 2001 12:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIFQYR>; Thu, 6 Sep 2001 12:24:17 -0400
Received: from whiterose.net ([64.65.220.94]:29189 "HELO whiterose.net")
	by vger.kernel.org with SMTP id <S271332AbRIFQYN>;
	Thu, 6 Sep 2001 12:24:13 -0400
Date: Thu, 6 Sep 2001 12:18:34 -0400 (EDT)
From: M Sweger <mikesw@ns1.whiterose.net>
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Linux 2.2.20pre9 problems with menuconfig.
Message-ID: <Pine.BSF.4.21.0109061156070.88489-100000@ns1.whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mec,
   Here is a list of problems and a solution to get
   "make menuconfig" to work in some menu selections
   that worked previously, but have been broken for awhile.
   I have located the problem and have included the
   solution for you to patch the 2.2.20pre patches
   and above along with possibly the 2.4.x kernels.

   In addition, although this problem and solution was
   for linux 2.2.19 and below, the original problem
   disappeared with 2.2.20pre9 which included modifications
   to the lxdialog subidr code. BUT, it introduced
   new problems which aren't as severe as the 2.2.19 problem.

   Here is a breakdown.


Problem:

   A). pertains to 2.2.19 and below kernels.

   when selecting menu options "Processor family" or
   "Maximum Physical Memory" under menuconfig, the menu
    structure for each of these selections is displayed
    partially missing. What is displayed is the following:
    a). a blue background, b). the title for kernel config,
    c). a partial menu with a gray background but the grey
        box doesn't contain the title (in yellow) nor the
        text message at the top of the grey box, "Use arrow
        keys....." and the Select/help text. 

        The part of the menu that is displayed is from the
        top of the menu down to the location where the
        menu box that is checked with an X is at. So if the
        first menu selection is checked, that is all you see.
        If the last menu selection is checked, then you see
        the whole menu. If a menu selection in the middle is
        checked, then only from the beginning to that menu
        option is shown.

     d). If the up/down cursor is moved a couple of menu
         selections up or down, then the display
         will refresh and display properly until you exit
         and reenter the menu option viewed and then
         item (c) reoccurs.

Problem #2:

      A). pertains to 2.2.19 and 2.2.20pre9 kernels.

      a). I guess you know that when the letters "S" and "E" are
          used as possible one character selection in the menu
          list, it overrides the capability associated with
          "Select" and "Exit". I.E. see the main menu since 
           "Scsi support" has "S" and so does "Select", but
           "Scsi support" is selected when "S" is typed, and
           not "Select" no matter how many times "S" is entered.

	   However, the arrow keys still work to make selection.

Problem #3:
 
       A). pertains to 2.2.20pre9 kernels.

         a).   when selecting menu options "Processor family" or
              "Maximum Physical Memory" under menuconfig, the menu
              structure for each of these selections is displayed
              as follows:

	      1). The "Select" option is highlighted.(ok!)
              2). The "Exit" button option is MISSING.(Broke!)
                  All other screens have it.
              3). The menu selection currently checked
                  is highlighted. HOWEVER, the cursor
                  on the screen isn't placed on the selection
                  checked but is put on the "Help" option. (Broke!)
                  All other screens always highlight
                  the first menu option since there are multiple
                  selections with data instead of multiple
                  selections with just one option.(this is OK!).




What changed:
 
       History: In kernel version 2.2.1 to 2.2.19pre7 the above
                problem #1 didn't exist, but when the kernel
                patch to 2.2.19pre8 was applied that changed
                the "C" software code that dealt with
	        "make menuconfig", the above problem started
                occuring and is still occuring with the latest
                2.2 kernels. I didn't complain about it since
                I thought it would be eventually fixed -- it hasn't
                been. Therefore, I started investigating the
                cause.

       What changed in patch:
                  a). a couple of statements
                              wmove(....)
                              wrefresh(...)/wnoutrefresh(...)
			      wgetch(...)

	          b). some code logic in,

		      menubox.c
		      checklist.c

		      that added "If(selected)" .... statements.

		   c). some code commented out in,

                       checklist.c

  
Solution to Problem #1 (2.2.19 and below):

 a). in the pre-patch-2.2.19-8 you commented out two lines in
     the file checklist.c. The lines are,

            wmove(dialog,y, x+1+ 14*selected):
            wrefresh(dialog);

       in the function print_buttons(...)

    These lines *must* be uncommented to correct my problem so that
    I don't have to move the cursor to get the screen to refresh
    and display the screen properly.

    My argument is if you were to grep for "selected" in all of the
    "C" files in the lxdialog directory, you would see other "C"
     programs that use similar statements (except the 14 is a
     different number). If the above statements caused some type
     of problem, then I'd expect all of the other routines, which
     are similar, to have similar types of problems: yet they aren't
      commented out. See the print_buttons() function in menubox.c
      yesno.c    etc. If you can't recreate this problem, then comment
      all lines in the "C" code in the subdir lxdialog that look
      similar to the above two statements but may have different numbers.
      Then do "make menuconfig" and start selecting things.

     The second part of my argument is that alot of the "C" programs
     have the same function name i.e. print_buttons(..) that have
     the same parameter list, but different variables, and do the
     same type of processing, but with different data. I suggest
     that *alot* of the redundancy of the functions be eliminated
     to ease code maintenance and prevent s/w functionality from
     being broke. I realize that some function calls with the
     same name have a few more parameters than the other, but NULLs
     could be passed as dummy data for example.

     The third part of my argument is that all print_item(..) functions
     defs *have* the "if (selected)" logic added and are consistent, thus
     all routines which are similar (see argument #2) should be the same.
     In this example, they are the same/consistent and justifies my
     argument in #2 about the commented out statements. see "C" programs
     checklist.c and menubox.c.

Solution to Problems #2 and #3: unknown!

System:
    I have Linux 2.2.19 (and now 2.2.20pre9) with egcs v1.1.2 and libc
    v2.0.6 and ncurses v5.0beta1 (this has never been a problem since I
    compiled it for  linux 2.2.1 and up, along with other apps using
    it. Thus this version *isn't* the issue with the above problem). 

    Hardware: Dell 333mhz intel Optiplex.

Conclusion:
      a). Uncomment the code mentioned above.
      b). Restructure the lxdialog code based around a common
          set of function calls to eliminate redundancy, but called
          with the necessary parameters to implement the necessary
          functionality. Eases s/w maintenance and establishes
          consistency in programming logic. IMHO.









    






