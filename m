Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129456AbRCLTVc>; Mon, 12 Mar 2001 14:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRCLTVN>; Mon, 12 Mar 2001 14:21:13 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:2067 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129456AbRCLTVJ>;
	Mon, 12 Mar 2001 14:21:09 -0500
Date: Mon, 12 Mar 2001 20:20:35 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: David Wragg <dpw@doc.ic.ac.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Helge Hafting <helgehaf@idb.hist.no>,
        Manoj Sontakke <manojs@sasken.com>, linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
Message-ID: <20010312202035.B23065@pcep-jamie.cern.ch>
In-Reply-To: <200103091152.MAA31645@cave.bitwizard.nl> <y7r7l1xl9tx.fsf@sytry.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <y7r7l1xl9tx.fsf@sytry.doc.ic.ac.uk>; from dpw@doc.ic.ac.uk on Sat, Mar 10, 2001 at 07:09:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wragg wrote:
> For modern machines, I'm not sure that quicksort on a linked list is
> typically much cheaper than mergesort on a linked list.
...
> For lists that don't fit into cache, the advantages of mergesort
> should become even greater if the literature on tape and disk sorts
> applies (though multiway merges rather than simple binary merges would
> be needed to minimize the impact of memory latency).
...
> Given this, mergesort might be generally preferable to quicksort for
> linked lists.  But I haven't investigated this idea thoroughly.  (The
> trick described above for avoiding an explicit stack also works for
> mergesort.)

Fwiw, below is a pretty good list mergesort.  It takes linear time on
"nearly sorted" lists (i.e. better than classic mergesort), and degrades
to O(n log n) worst case (i.e. better than quicksort).  It's
non-recursive and uses a small bounded stack.

enjoy ;-)

-- Jamie

/* A macro to sort linked lists efficiently.
   O(n log n) worst case, O(n) on nearly sorted lists.

   Copyright (C) 1995, 1996, 1999 Jamie Lokier.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA */

#ifndef __fast_merge_sort_h
#define __fast_merge_sort_h

/* {{{ Description */

/* This macro sorts singly-linked lists efficiently.

   To sort a doubly-linked list: sort, then traverse the forward
   links to regenerate the reverse links.

   Written by Jamie Lokier <jamie@imbolc.ucc.ie>, 1995-1999.
   Version 2.0.

   Properties
   ==========

   1. Takes O(n) time to sort a nearly-sorted list; very fast indeed.

   2. Takes O(n log n) time for worst case and for random-order average.
      Worst case is a reversed list.  Sorting is still fast.
      NB: This is much faster than unmodified quicksort, which is O(n^2).

   3. Requires no extra memory: sorts in place like heapsort and
      quicksort.  Uses a small array (typically 32 pointers) on the
      stack.

   4. Stable: equal elements are kept in the same relative order.

   5. Macro so the comparisons and structure modifications are in line.
      You typically have a C function which calls the macro and does
      very little else.  The sorting code is not small enough to be worth
      inlining in its caller; however, the comparisons and strucure
      modifications generally _are_ worth inlining into the sorting code.

   Requirements
   ============

   Any singly-linked list structure.  You provide the structure type,
   and the name of the structure member to reach the next element, and
   the address of the first element.  The last element is identified by
   having a null next pointer.

   How to sort a list
   ==================

   Call as `FAST_MERGE_SORT (LIST, TYPE, NEXT, LESS_THAN_OR_EQUAL_P)'.

      `LIST' points to the first node in the list, or can be null.
      Afterwards it is updated to point to the beginning of the sorted list.

      `TYPE' is the type of each node in the linked list.

      `NEXT' is the name of the structure member containing the links.
      In C++, this can be a call to a member function which returns a
      non-const reference.

      `LESS_THAN_OR_EQUAL_P' is the name of a predicate which, given two
      pointers to objects of type `TYPE', determines if the first is
      less than or equal to the second.  The equality test is important
      to keep the sort stable (see earlier).

      The total number of items must fit in `unsigned long'.

   How to update a sorted list
   ===========================

   A call is provided to sort a list, and combine that with another
   which is already sorted.  This is useful when you've sorted a list,
   but later want to add some new elements.  The code is optimised by
   assuming that the already sorted list is likely to be the larger.

   The already sorted list comes earlier in the input, for the purpose
   of stable sorting.  That is, if an element in the already sorted list
   compares equal to one in the list to sort, the element from the
   already sorted list will come first in the output.

   Call as `FAST_MERGE_SORT_APPEND (ALREADY_SORTED, LIST, TYPE, NEXT,
   LESS_THAN_OR_EQUAL_P)'.

      `ALREADY_SORTED' points to the first node of an already sorted
      list, or can be null.  If the list isn't sorted already, the
      result is undefined.

      `LIST' points to the first node in the list to be sorted, or can
      be null.  Afterwards it is updated to point to the beginning of
      the combined, sorted list.

   Algorithm
   =========

   It identifies non-strictly ascending runs (those where Elt(n) <=
   Elt(n+1)), and combines ascending runs in a hybrid of bottom-up and
   non-recursive, top-down mergesort.

   Robert Sedgewick, ``Algorithms in C'', says that merging runs incurs
   more overhead in practice than it saves, because of the extra
   processing to identify the runs, except when the list is very nearly
   sorted.  He says that is because the extra processing occurs in the
   inner loop, which suggests that he means to repeatedly identify pairs
   of runs and merge them, in a bottom-up process.  (That is consistent
   with the adjacent text).  The implementation here only identifies the
   runs once, so Robert's argument doesn't apply.

   Five optimisations are implemented:
  
     1. Runs of ascending elements are identified just once.
  
     2. A stack of runs is maintained.  This is analogous to the
        explicit stack used in a non-recursive, top-down implementation.
        However, the pure top-down algorithm could not identify runs of
        ascending elements once, without requiring additional storage
        for the runs' head nodes.
  
     3. A top-down implementation must divide each list into two smaller
        lists.  This implementation does not do that.

     4. A decision tree is used to sort up to three elements per run, so
        the initial runs are all at least three elements long (except at
        the end of the list).

     5. Unnecessary memory writes are avoided by using two loops for
        merging.  Each loop identifies contiguous elements from one
        input list.  This also biases the code path to the contiguous
        cases.

   As well as being fast, identifying ascending runs allows the sort to
   be "stable", meaning that objects that compare equal are kept in the
   same relative order.

   With some extra complexity, and overhead, it is possible to identify
   alternating ascending and descending runs.  That is not implemented
   here because it wouldn't be useful for most applications.

   Notes
   =====

   This loop forces initial runs to be at least 3 elements long, if
   there are enough elements.  I haven't properly tested if the extra
   code for this is worthwhile.  It seems to win most times, but not
   all.  It may be that even the code to force 2 element runs is
   unnecessary.  In one case, forcing at least 2 elements was about 5%
   worse than forcing at least 3 elements _or_ accepting 1 element; the
   latter two cases had very similar numbers of comparisons.

   Need to count (a) time; (b) comparisons.

   An earlier version of this thing was measured on serious real time
   code, and was pretty fast.  */

/* }}} */


#if !defined(__GNUC__) || defined(__STRICT_ANSI__)
#define FAST_MERGE_SORT(__LIST, __TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P)	\
  __FAST_MERGE_SORT(1, 0, __LIST, __TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P)
#define FAST_MERGE_SORT_APPEND(__ALREADY_SORTED, __LIST,		\
			       __TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P)	\
  __FAST_MERGE_SORT(0, __ALREADY_SORTED, __LIST,			\
		    __TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P)
#define __FAST_MERGE_SORT_LABEL(name) \
  __FAST_MERGE_SORT_LABEL2 (name,__LINE__)
#define __FAST_MERGE_SORT_LABEL2(name,line) \
  __FAST_MERGE_SORT_LABEL3 (name,line)
#ifdef __STDC__
#define __FAST_MERGE_SORT_LABEL3(name,line) \
  __FAST_MERGE_SORT_ ## name ## _ ## line
#else
#define __FAST_MERGE_SORT_LABEL3(name,line) \
  __FAST_MERGE_SORT_/**/name/**/_/**/line
#endif
#else
#define FAST_MERGE_SORT(__LIST, __TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P)	      \
  do ({									      \
    __label__ __merge_1, __merge_2, __merge_done, __final_merge, __empty_list;\
    __FAST_MERGE_SORT(1, 0, __LIST, __TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P);  \
  }); while (0)
#define FAST_MERGE_SORT_APPEND(__ALREADY_SORTED, __LIST,		      \
			       __TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P)	      \
  do ({									      \
    __label__ __merge_1, __merge_2, __merge_done, __final_merge, __empty_list;\
    __FAST_MERGE_SORT(0, __ALREADY_SORTED, __LIST,			      \
		      __TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P);		      \
  }); while (0)
#define __FAST_MERGE_SORT_LABEL(name) __ ## name
#endif

#define __FAST_MERGE_SORT\
(__ASG, __ALREADY_SORTED, __LIST, __NODE_TYPE, __NEXT, __LESS_THAN_OR_EQUAL_P)\
  do									    \
    {									    \
      __NODE_TYPE * _stack [8 * sizeof (unsigned long)];		    \
      __NODE_TYPE ** _stack_ptr           = _stack;			    \
      unsigned long _run_number           = 0UL - 1;			    \
      register __NODE_TYPE * _list        = (__LIST);			    \
      register __NODE_TYPE * _current_run = (__ALREADY_SORTED);		    \
									    \
      /* Handle zero length separately. */				    \
      if (__ASG && (_list == 0 || _list->__NEXT == 0))			    \
	break;								    \
      if (!__ASG && _list == 0)						    \
        goto __FAST_MERGE_SORT_LABEL (empty_list);			    \
									    \
      while (_list != 0)						    \
	{								    \
	  /* Identify a run.  Ensure that the run is at least three	    \
	     elements long, if there are three elements.  Rearrange them    \
	     to be in order, if necessary. */				    \
	  *_stack_ptr++ = _current_run;					    \
	  _current_run = _list;						    \
									    \
	  /* This conditional makes the runs at least 2 long. */	    \
	  if (_list->__NEXT != 0)					    \
	    {								    \
	      if (__LESS_THAN_OR_EQUAL_P (_list, (_list->__NEXT)))	    \
		_list = _list->__NEXT;					    \
	      else							    \
		{							    \
		  /* Exchange the first two elements. */		    \
		  _current_run = _list->__NEXT;				    \
		  _list->__NEXT = _current_run->__NEXT;			    \
		  _current_run->__NEXT = _list;				    \
		}							    \
									    \
	      /* This conditional makes the runs at least 3 long. */	    \
	      if (_list->__NEXT != 0)					    \
		{							    \
		  if (__LESS_THAN_OR_EQUAL_P (_list, _list->__NEXT))	    \
		    _list = _list->__NEXT;				    \
		  else							    \
		    {							    \
		      /* Move the third element back to the right place. */ \
		      __NODE_TYPE * _tmp = _list->__NEXT;		    \
		      _list->__NEXT = _tmp->__NEXT;			    \
									    \
		      if (__LESS_THAN_OR_EQUAL_P (_current_run, _tmp))	    \
			{						    \
			  _tmp->__NEXT = _list;				    \
			  _current_run->__NEXT = _tmp;			    \
			}						    \
		      else						    \
			{						    \
			  _tmp->__NEXT = _current_run;			    \
			  _current_run->__NEXT = _list;			    \
			  _current_run = _tmp;				    \
			}						    \
		    }							    \
									    \
		  /* Find more ascending elements. */			    \
		  while (_list->__NEXT != 0				    \
			 && __LESS_THAN_OR_EQUAL_P (_list,		    \
						    (_list->__NEXT)))	    \
		    _list = _list->__NEXT;				    \
		}							    \
	    }								    \
									    \
	  {								    \
	    __NODE_TYPE * _tmp = _list->__NEXT;				    \
	    _list->__NEXT = 0;						    \
	    _list = _tmp;						    \
	  }								    \
									    \
	  /* Half the runs are pushed onto the stack without being	    \
	     merged until another run has been found.  Test for that	    \
	     here to keep this bit of the loop fast. */			    \
									    \
	  if (!(++_run_number & 1))					    \
	    continue;							    \
									    \
	  /* Now merge the appropriate number of times.  The idea is to	    \
	     merge pairs of runs, then pairs of those merged pairs, and	    \
	     so on.  One strategy is to store a "merge depth" with each	    \
	     stack entry, indicating the number of merge operations done    \
	     to produce that entry, and only merge the current run with	    \
	     the top one if they have the same merge depth.  Another is	    \
	     to count the number of runs identified so far, and work out    \
	     what to do from that count.  The latter strategy is	    \
	     implemented here.						    \
									    \
	     The sequence 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,	    \
	     4, etc. is the number of merge operations to do after each	    \
	     run has been identified.  That number is the same as the	    \
	     number of consecutive `1' bits at the bottom of		    \
	     `_run_number' here. */					    \
									    \
	__FAST_MERGE_SORT_LABEL (final_merge):				    \
	  {								    \
	    unsigned long _tmp_run_number = _run_number;		    \
									    \
	    do								    \
	      {								    \
		/* Here, merge `_current_run' with the one on top of the    \
		   stack.  The new run is stored in `_current_run'.  The    \
		   order of arguments to the comparison function is	    \
		   important, in order for the sort to be stable.  The	    \
		   run on the stack was earlier in the original list	    \
		   than `_current_run'.					    \
									    \
		   Two loops are used mainly to reduce the number of	    \
		   memory writes.  They also bias the loops to run	    \
		   quickest where contiguous elements are taken from the    \
		   same input list. */					    \
									    \
		register __NODE_TYPE * _other_run   = *--_stack_ptr;	    \
		__NODE_TYPE * _output_run           = _other_run;	    \
		register __NODE_TYPE ** _output_ptr = &_output_run;	    \
									    \
		for (;;)						    \
		  {							    \
		    if (__LESS_THAN_OR_EQUAL_P (_other_run, _current_run))  \
		      {							    \
		      __FAST_MERGE_SORT_LABEL (merge_1):		    \
			_output_ptr = &_other_run->__NEXT;		    \
			_other_run = *_output_ptr;			    \
			if (_other_run != 0)				    \
			  continue;					    \
			*_output_ptr = _current_run;			    \
			goto __FAST_MERGE_SORT_LABEL (merge_done);	    \
		      }							    \
		    *_output_ptr = _current_run;			    \
		    goto __FAST_MERGE_SORT_LABEL (merge_2);		    \
		  }							    \
									    \
		/* The body of this loop is only reached by jumping	    \
		   into it. */						    \
									    \
		for (;;)						    \
		  {							    \
		    if (!__LESS_THAN_OR_EQUAL_P (_other_run, _current_run)) \
		      {							    \
		      __FAST_MERGE_SORT_LABEL (merge_2):		    \
			_output_ptr = &_current_run->__NEXT;		    \
			_current_run = *_output_ptr;			    \
			if (_current_run != 0)				    \
			  continue;					    \
			*_output_ptr = _other_run;			    \
			goto __FAST_MERGE_SORT_LABEL (merge_done);	    \
		      }							    \
		    *_output_ptr = _other_run;				    \
		    goto __FAST_MERGE_SORT_LABEL (merge_1);		    \
		  }							    \
									    \
	      __FAST_MERGE_SORT_LABEL (merge_done):			    \
		_current_run = _output_run;				    \
	      }								    \
	    while ((_tmp_run_number >>= 1) & 1);			    \
	  }								    \
	}								    \
									    \
      /* There are no more runs in the input list now.  Just merge runs	    \
	 on the stack together until there is only one.  Keep the code	    \
	 small by using the merge code in the main loop.  These tests	    \
	 are outside the main loop to keep the main loop as fast and	    \
	 small as possible.  This jumps to a point which shouldn't	    \
	 disrupt the quality of the main loop's compiled code too	    \
	 much. */							    \
									    \
      _run_number = (1UL << (_stack_ptr					    \
			     - (_stack + (__ASG || _stack [0] == 0)))) - 1; \
      if (_run_number)							    \
	goto __FAST_MERGE_SORT_LABEL (final_merge);			    \
									    \
    __FAST_MERGE_SORT_LABEL (empty_list):				    \
      (__LIST) = _current_run;						    \
    }									    \
  while (0)

#endif /* __fast_merge_sort_h */
